import router from '@ohos.router';
import http from '@ohos.net.http';
import { BusinessError } from '@ohos.base';
import { StorageUtil } from '../common/utils/StorageUtil';

class ApiMessage {
  role: string = '';
  content: string = '';
}

class ChatRequest {
  model: string = '';
  messages: ApiMessage[] = [];
  stream: boolean = false;
  temperature: number = 0.7;
}

class Choice {
  message: ApiMessage = new ApiMessage();
}

class ChatResponse {
  choices: Choice[] = [];
}

@Entry
@Component
struct AILearning {
  @State topic: string = '';
  @State learningContent: string = '';
  @State isGenerating: boolean = false;
  @State apiKey: string = '';
  @State apiEndpoint: string = '';
  @State modelName: string = '';
  @State statusMessage: string = '';

  scroller: Scroller = new Scroller();

  async aboutToAppear() {
    this.apiKey = await StorageUtil.getInstance().get('ai_api_key', '') as string;
    this.apiEndpoint = await StorageUtil.getInstance().get('ai_api_endpoint', 'https://api.openai.com/v1') as string;
    let storedModel = await StorageUtil.getInstance().get('ai_model_name', 'gpt-3.5-turbo') as string;
    if (!storedModel) {
      storedModel = 'gpt-3.5-turbo';
    }
    this.modelName = storedModel;
  }

  build() {
    Column() {
      // Header
      Row() {
        Button({ type: ButtonType.Circle, stateEffect: true }) {
          Image($r('app.media.image_icon'))
            .width(20)
            .height(20)
            .fillColor('#191919')
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.White)
        .shadow({ radius: 5, color: 'rgba(0,0,0,0.05)' })
        .onClick(() => {
          try {
            router.back();
          } catch (err) {
            console.error(`Back failed: ${err}`);
          }
        })

        Text('AI 编程导师')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#191919')
          .margin({ left: 16 })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12, bottom: 12 })

      Scroll(this.scroller) {
        Column() {
          // Input Section
          if (!this.learningContent) {
            Column() {
              Text('你想学习什么？')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 20, bottom: 8 })
                .width('100%')
              
              Text('输入任何编程概念、语言特性或算法，AI 将为你生成详细的学习指南。')
                .fontSize(14)
                .fontColor('#999999')
                .margin({ bottom: 30 })
                .width('100%')

              TextArea({ placeholder: '例如：\n- 解释 React 的 useEffect Hook\n- 如何在 Python 中实现快速排序\n- 什么是闭包？\n- 讲解一下 Rust 的所有权机制', text: this.topic })
                .height(150)
                .width('100%')
                .borderRadius(12)
                .backgroundColor('#F5F7FA')
                .margin({ bottom: 20 })
                .onChange((value: string) => {
                  this.topic = value;
                })

              // Status Message
              if (this.statusMessage) {
                Text(this.statusMessage)
                  .fontSize(14)
                  .fontColor(this.statusMessage.includes('失败') || this.statusMessage.includes('错误') ? '#FF4D4F' : '#1890FF')
                  .margin({ bottom: 20 })
                  .textAlign(TextAlign.Center)
                  .width('100%')
              }

              Button(this.isGenerating ? '正在生成教程...' : '开始学习')
                .width('100%')
                .height(56)
                .backgroundColor('#1890FF')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .enabled(!this.isGenerating)
                .opacity(this.isGenerating ? 0.7 : 1)
                .shadow({ radius: 10, color: 'rgba(24, 144, 255, 0.3)', offsetY: 4 })
                .onClick(() => {
                  this.startLearning();
                })
            }
            .padding(20)
          } else {
            // Content Display Section
            Column() {
              Text(this.topic)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .margin({ bottom: 16 })
                .width('100%')
              
              Text(this.learningContent)
                .fontSize(16)
                .fontColor('#333333')
                .lineHeight(28)
                .width('100%')
                .margin({ bottom: 30 })

              Button('学习新知识')
                .width('100%')
                .height(50)
                .backgroundColor('#F0F0F0')
                .fontColor('#333333')
                .fontSize(16)
                .onClick(() => {
                  this.learningContent = '';
                  this.topic = '';
                  this.statusMessage = '';
                })
            }
            .padding(20)
          }
        }
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  async startLearning() {
    if (!this.apiKey) {
      AlertDialog.show({
        title: '提示',
        message: '请先在 AI 助手页面配置 API Key',
        confirm: {
          value: '知道了',
          action: () => {}
        }
      });
      return;
    }

    if (!this.topic.trim()) {
      this.statusMessage = '请输入你想学习的内容';
      return;
    }

    this.isGenerating = true;
    this.statusMessage = 'AI 正在为你准备学习资料...';

    const prompt = `
You are an expert programming tutor. The user wants to learn about: "${this.topic}".
Please provide a comprehensive, easy-to-understand tutorial or explanation.

Structure your response clearly:
1. **Introduction**: Briefly explain what it is and why it's important.
2. **Key Concepts**: Core principles or mechanisms.
3. **Code Examples**: Provide clear, well-commented code examples (in the appropriate language).
4. **Common Pitfalls/Best Practices**: What to watch out for.
5. **Summary**: A quick wrap-up.

Format the output as plain text (you can use simple bullet points and indentation, but avoid markdown code blocks like \`\`\` as they might not render perfectly in simple text views, just separate code with clear spacing).
Keep the tone encouraging and educational.
`;

    let httpRequest = http.createHttp();
    
    // Construct URL logic reused
    let endpoint = this.apiEndpoint.trim();
    while (endpoint.endsWith('/')) {
      endpoint = endpoint.slice(0, -1);
    }
    let url = endpoint;
    if (url.endsWith('/chat/completions')) {
    } else if (url.endsWith('/v1')) {
      url = `${endpoint}/chat/completions`;
    } else {
      url = `${endpoint}/v1/chat/completions`;
    }

    const apiMessage = new ApiMessage();
    apiMessage.role = 'user';
    apiMessage.content = prompt;

    let requestBody = new ChatRequest();
    requestBody.model = this.modelName || 'gpt-3.5-turbo';
    requestBody.messages = [apiMessage];

    try {
      const response = await httpRequest.request(url, {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${this.apiKey}`
        },
        extraData: JSON.stringify(requestBody),
        expectDataType: http.HttpDataType.STRING,
        readTimeout: 60000,
        connectTimeout: 60000
      });

      if (response.responseCode === 200) {
        let rawResult = '';
        if (typeof response.result === 'string') {
          rawResult = response.result;
        } else {
          rawResult = JSON.stringify(response.result);
        }

        const result = JSON.parse(rawResult) as ChatResponse;
        const content = result.choices?.[0]?.message?.content;

        if (content) {
          this.learningContent = content;
          this.statusMessage = '';
        } else {
          this.statusMessage = 'AI 没有返回内容';
        }
      } else {
        this.statusMessage = `请求失败: ${response.responseCode}`;
      }
    } catch (err) {
      this.statusMessage = `发生错误: ${(err as BusinessError).message}`;
      console.error('AI Learning Error:', err);
    } finally {
      this.isGenerating = false;
      httpRequest.destroy();
    }
  }
}
