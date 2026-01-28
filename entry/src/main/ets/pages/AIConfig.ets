import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { StorageUtil } from '../common/utils/StorageUtil';
import { AIProvider } from '../common/constants/MockAIModels';
import { AI_PROVIDERS } from '../common/constants/MockAIModels';

/**
 * AI Configuration Page
 * Allows users to configure AI model settings (API Key, Endpoint, etc.)
 */
@Entry
@Component
struct AIConfig {
  @State apiKey: string = '';
  @State apiEndpoint: string = 'https://api.openai.com/v1';
  @State modelName: string = 'gpt-3.5-turbo';
  @State selectedProviderIndex: number = -1;

  async aboutToAppear() {
    // Load existing config
    try {
      this.apiKey = await StorageUtil.getInstance().get('ai_api_key', '') as string;
      this.apiEndpoint = await StorageUtil.getInstance().get('ai_api_endpoint', 'https://api.openai.com/v1') as string;
      this.modelName = await StorageUtil.getInstance().get('ai_model_name', 'gpt-3.5-turbo') as string;
      
      // Try to match current endpoint with a provider
      this.selectedProviderIndex = AI_PROVIDERS.findIndex(p => this.apiEndpoint.includes(p.defaultEndpoint));
    } catch (err) {
      console.error(`Failed to load config: ${err}`);
    }
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('<')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .onClick(() => router.back())
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        
        Text('AI 模型配置')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .margin({ right: 40 })
      }
      .height(56)
      .width('100%')
      .backgroundColor(Color.White)
      .shadow({ radius: 2, offsetY: 1, color: '#F0F0F0' })

      Scroll() {
        Column({ space: 20 }) {
          
          // Provider Selection
          Column() {
            Text('快速选择供应商')
              .fontSize(14)
              .fontColor('#969799')
              .margin({ bottom: 12, left: 16 })
              .width('100%')
            
            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(AI_PROVIDERS, (provider: AIProvider, index: number) => {
                Button(provider.name)
                  .type(ButtonType.Normal)
                  .fontSize(12)
                  .fontColor(this.selectedProviderIndex === index ? Color.White : '#333333')
                  .backgroundColor(this.selectedProviderIndex === index ? '#1890FF' : '#F5F5F5')
                  .borderRadius(16)
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .margin({ right: 8, bottom: 8 })
                  .onClick(() => {
                    this.selectedProviderIndex = index;
                    this.apiEndpoint = provider.defaultEndpoint;
                    if (!provider.models.includes(this.modelName)) {
                      this.modelName = provider.models[0];
                    }
                  })
              })
            }
            .padding({ left: 16, right: 16 })
          }
          .width('100%')

          // Model Config Form
          Column() {
            this.InputGroup('模型名称', 'e.g. gpt-3.5-turbo', this.modelName, (val) => this.modelName = val)
            Divider().color('#F0F0F0').margin({ left: 16, right: 16 })
            this.InputGroup('API 地址', 'https://api.openai.com/v1', this.apiEndpoint, (val) => this.apiEndpoint = val)
            Divider().color('#F0F0F0').margin({ left: 16, right: 16 })
            this.InputGroup('API Key', 'sk-...', this.apiKey, (val) => this.apiKey = val, InputType.Password)
          }
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ left: 16, right: 16 })
          .padding({ top: 8, bottom: 8 })

          // Model Quick Select (if provider selected)
          if (this.selectedProviderIndex !== -1) {
            Column() {
              Text('推荐模型')
                .fontSize(14)
                .fontColor('#969799')
                .margin({ bottom: 12, left: 16 })
                .width('100%')
              
              Flex({ wrap: FlexWrap.Wrap }) {
                ForEach(AI_PROVIDERS[this.selectedProviderIndex].models, (model: string) => {
                  Button(model)
                    .type(ButtonType.Normal)
                    .fontSize(12)
                    .fontColor(this.modelName === model ? Color.White : '#333333')
                    .backgroundColor(this.modelName === model ? '#1890FF' : '#F5F5F5')
                    .borderRadius(16)
                    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                    .margin({ right: 8, bottom: 8 })
                    .onClick(() => {
                      this.modelName = model;
                    })
                })
              }
              .padding({ left: 16, right: 16 })
            }
            .width('100%')
          }

          // Save Button
          Column() {
            Button('保存配置')
              .type(ButtonType.Capsule)
              .width('100%')
              .height(44)
              .backgroundColor('#1890FF')
              .onClick(() => {
                this.saveConfig();
              })
          }
          .padding({ left: 16, right: 16, bottom: 30 })
        }
        .padding({ top: 20 })
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F8FA')
  }

  @Builder
  InputGroup(label: string, placeholder: string, value: string, onChange: (val: string) => void, type: InputType = InputType.Normal) {
    Row() {
      Text(label)
        .width(80)
        .fontSize(14)
        .fontColor('#333333')
      
      TextInput({ text: value, placeholder: placeholder })
        .type(type)
        .layoutWeight(1)
        .height(40)
        .fontSize(14)
        .backgroundColor(Color.Transparent)
        .onChange(onChange)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
  }

  async saveConfig() {
    try {
      await StorageUtil.getInstance().put('ai_api_key', this.apiKey);
      await StorageUtil.getInstance().put('ai_api_endpoint', this.apiEndpoint);
      await StorageUtil.getInstance().put('ai_model_name', this.modelName);
      
      promptAction.showToast({ message: '配置已保存', duration: 2000 });
      setTimeout(() => {
        router.back();
      }, 1000);
    } catch (err) {
      console.error(`Failed to save config: ${err}`);
      promptAction.showToast({ message: '保存失败，请重试' });
    }
  }
}
