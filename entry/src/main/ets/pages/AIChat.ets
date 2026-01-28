import router from '@ohos.router';
import http from '@ohos.net.http';
import { BusinessError } from '@ohos.base';
import { StorageUtil } from '../common/utils/StorageUtil';
import { ChatMessage } from '../model/types';

class ApiMessage {
  role: string = '';
  content: string = '';
}

class ChatRequest {
  model: string = '';
  messages: ApiMessage[] = [];
  stream: boolean = false;
}

class Choice {
  message: ApiMessage = new ApiMessage();
}

class ChatResponse {
  choices: Choice[] = [];
}

/**
 * AI Chat Page - Redesigned
 */
@Component
export struct AIChat {
  @State messages: ChatMessage[] = [
    {
      id: '1',
      role: 'assistant',
      content: '你好！我是你的AI助手，有什么可以帮你的吗？',
      type: 'text',
      timestamp: new Date().getTime()
    }
  ];
  @State inputText: string = '';
  @State isTyping: boolean = false;
  @State apiKey: string = '';
  @State apiEndpoint: string = '';
  @State modelName: string = '';

  scroller: Scroller = new Scroller();

  async onPageShow() {
    console.info('AIChat onPageShow: Reloading config');
    await this.loadConfig();
  }

  async aboutToAppear() {
    console.info('AIChat aboutToAppear');
    await this.loadConfig();

    // Load Chat History
    const historyJson = await StorageUtil.getInstance().get('ai_chat_history', '[]') as string;
    try {
      const history = JSON.parse(historyJson) as ChatMessage[];
      if (history.length > 0) {
        this.messages = history;
      }
    } catch (e) {
      console.error('Failed to load chat history', e);
    }
  }

  async loadConfig() {
    // Load config
    this.apiKey = await StorageUtil.getInstance().get('ai_api_key', '') as string;
    this.apiEndpoint = await StorageUtil.getInstance().get('ai_api_endpoint', 'https://api.openai.com/v1') as string;
    let storedModel = await StorageUtil.getInstance().get('ai_model_name', 'gpt-3.5-turbo') as string;
    if (!storedModel) {
      storedModel = 'gpt-3.5-turbo';
    }
    this.modelName = storedModel;
  }

  async saveHistory() {
    try {
      // Limit history to last 50 messages to prevent storage issues
      const historyToSave = this.messages.slice(-50);
      await StorageUtil.getInstance().put('ai_chat_history', JSON.stringify(historyToSave));
    } catch (e) {
      console.error('Failed to save chat history', e);
    }
  }

  async clearHistory() {
    this.messages = [
      {
        id: '1',
        role: 'assistant',
        content: '你好！我是你的AI助手，有什么可以帮你的吗？',
        type: 'text',
        timestamp: new Date().getTime()
      }
    ];
    await this.saveHistory();
  }

  confirmClear() {
    AlertDialog.show({
      title: '清除记录',
      message: '确定要清空所有聊天记录吗？',
      primaryButton: {
        value: '取消',
        action: () => {}
      },
      secondaryButton: {
        value: '清空',
        fontColor: '#FF4D4F',
        action: () => {
          this.clearHistory();
        }
      }
    })
  }

  build() {
    Column() {
      // Modern Header
      Row() {
        // Center: Title
        Column() {
          Text('AI 助手')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#191919')
          Text(this.modelName || '未配置模型')
            .fontSize(10)
            .fontColor(this.apiKey ? '#52C41A' : '#FF4D4F')
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center) // Center items

        // Right: Actions
        Row({ space: 16 }) {
          Text('清空')
            .fontSize(14)
            .fontColor('#666666')
            .onClick(() => this.confirmClear())
          
          Text('设置')
            .fontSize(14)
            .fontColor('#666666')
            .onClick(() => router.pushUrl({ url: 'pages/AIConfig' }))
        }
        .padding({ right: 16 })
      }
      .height(56)
      .width('100%')
      .backgroundColor(Color.White)
      .shadow({ radius: 2, offsetY: 1, color: '#F0F0F0' })

      // Chat Area
      List({ scroller: this.scroller }) {
        ForEach(this.messages, (msg: ChatMessage) => {
          ListItem() {
            Row() {
              // AI Avatar
              if (msg.role === 'assistant') {
                Image($r('app.media.image_icon'))
                  .width(36)
                  .height(36)
                  .borderRadius(18)
                  .backgroundColor('#E6F7FF')
                  .padding(8)
                  .margin({ right: 8 })
                  .alignSelf(ItemAlign.Start)
              } else {
                Blank().width(44) // Spacing for alignment
              }

              // Message Bubble
              Column() {
                if (msg.type === 'image' && msg.mediaUrl) {
                  Image(msg.mediaUrl)
                    .width(200)
                    .borderRadius(8)
                    .margin({ bottom: 4 })

                } else {
                  Text(msg.content)
                    .fontSize(16)
                    .fontColor(msg.role === 'user' ? Color.White : '#333333')
                    .lineHeight(24)
                }
              }
              .backgroundColor(msg.role === 'user' ? '#1890FF' : '#FFFFFF')
              .padding({ top: 12, bottom: 12, left: 16, right: 16 })
              .borderRadius({
                topLeft: 16,
                topRight: 16,
                bottomLeft: msg.role === 'user' ? 16 : 4,
                bottomRight: msg.role === 'user' ? 4 : 16
              })
              .shadow({ radius: 5, color: 'rgba(0,0,0,0.05)', offsetY: 2 })
              .constraintSize({ maxWidth: '75%' })

              // User Avatar
              if (msg.role === 'user') {
                 // Avatar placeholder
              }
            }
            .width('100%')
            .justifyContent(msg.role === 'user' ? FlexAlign.End : FlexAlign.Start)
            .padding({ top: 8, bottom: 8, left: 16, right: 16 })
          }
        }, (msg: ChatMessage) => msg.id)

        if (this.isTyping) {
          ListItem() {
            Row() {
              Image($r('app.media.image_icon'))
                .width(36)
                .height(36)
                .borderRadius(18)
                .backgroundColor('#E6F7FF')
                .padding(8)
                .margin({ right: 8 })
              
              Text('正在思考...')
                .fontSize(12)
                .fontColor('#999999')
                .backgroundColor('#FFFFFF')
                .padding({ top: 8, bottom: 8, left: 12, right: 12 })
                .borderRadius(16)
            }
            .padding({ left: 16, top: 8 })
          }
        }
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor('#F5F7FA')
      .alignListItem(ListItemAlign.Start)

      // Input Area
      Column() {
        Row() {
          TextInput({ placeholder: '输入消息...', text: this.inputText })
            .layoutWeight(1)
            .height(44)
            .backgroundColor('#F5F7FA')
            .borderRadius(22)
            .padding({ left: 20, right: 20 })
            .onChange((value: string) => {
              this.inputText = value;
            })
            .onSubmit(() => {
              this.sendMessage();
            })

          Button() {
            Image($r('app.media.image_icon')) // Send icon
              .width(20)
              .height(20)
              .fillColor(Color.White)
          }
          .width(44)
          .height(44)
          .type(ButtonType.Circle)
          .backgroundColor('#1890FF')
          .margin({ left: 12 })
          .onClick(() => {
            this.sendMessage();
          })
          .shadow({ radius: 5, color: 'rgba(24, 144, 255, 0.3)', offsetY: 2 })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .backgroundColor(Color.White)
        .shadow({ radius: 10, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
      }
    }
    .width('100%')
    .height('100%')
  }

  async sendMessage(customMsg?: ChatMessage) {
    if (!customMsg && !this.inputText.trim()) return;
    
    if (!this.apiKey) {
      AlertDialog.show({
        title: '提示',
        message: '请先点击右上角设置图标，配置 AI 模型参数',
        confirm: {
          value: '去配置',
          action: () => {
            router.pushUrl({ url: 'pages/AIConfig' });
          }
        }
      });
      return;
    }

    let userMsg: ChatMessage;
    if (customMsg) {
      userMsg = customMsg;
    } else {
      userMsg = {
        id: new Date().getTime().toString(),
        role: 'user',
        content: this.inputText,
        type: 'text',
        timestamp: new Date().getTime()
      };
      this.messages.push(userMsg);
      this.saveHistory(); // Save after user message
      this.inputText = '';
      this.scroller.scrollEdge(Edge.Bottom);
    }

    this.isTyping = true;

    // Prepare API Request
    let httpRequest = http.createHttp();
    
    // Construct URL
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

    // Construct Messages History
    const apiMessages: ApiMessage[] = [];
    
    for (let i = 0; i < this.messages.length; i++) {
      const m = this.messages[i];
      let msg = new ApiMessage();
      msg.role = m.role;
      
      // Text Message
      msg.content = m.content;
      apiMessages.push(msg);
    }

    let requestBody = new ChatRequest();
    requestBody.model = this.modelName || 'gpt-3.5-turbo';
    requestBody.messages = apiMessages;
    requestBody.stream = false;

    try {
      const response = await httpRequest.request(url, {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${this.apiKey}`,
          'Connection': 'keep-alive'
        },
        extraData: JSON.stringify(requestBody),
        expectDataType: http.HttpDataType.STRING,
        readTimeout: 120000,
        connectTimeout: 120000,
        usingProtocol: http.HttpProtocol.HTTP1_1,
        priority: 1
      });

      console.info(`AI Response Code: ${response.responseCode}`);
      console.info(`AI Response Result Type: ${typeof response.result}`);
      
      // We expect string now due to expectDataType, but double check
      let rawResult = '';
      if (typeof response.result === 'string') {
        rawResult = response.result;
      } else {
        rawResult = JSON.stringify(response.result);
      }
      console.info(`AI Response Result: ${rawResult}`);

      if (response.responseCode === 200) {
        try {
            // Check if it looks like HTML (common error when endpoint is wrong)
             if (rawResult.trim().startsWith('<')) {
                throw new Error("返回了HTML内容而非JSON。\n\n可能原因：\n1. 您配置的是网站主页而非API地址\n2. API地址缺少 '/v1' 后缀\n\n当前尝试请求的完整URL: " + url);
             }
            
            const result = JSON.parse(rawResult) as ChatResponse;

            // Basic validation
            if (!result.choices || !Array.isArray(result.choices) || result.choices.length === 0) {
               // Try to handle case where it might be a direct error object
               let resObj = JSON.parse(rawResult) as Record<string, Object>;
               if (resObj['error']) {
                  let errObj = resObj['error'] as Record<string, Object>;
                  throw new Error(`API返回错误: ${errObj['message'] || JSON.stringify(errObj)}`);
               }
               throw new Error("响应格式不正确: 缺少 choices 字段");
            }

            const content = result.choices?.[0]?.message?.content;
            
            const aiMsg: ChatMessage = {
              id: (new Date().getTime() + 1).toString(),
              role: 'assistant',
              content: typeof content === 'string' ? content : '收到多模态回复，暂不支持显示',
              timestamp: new Date().getTime()
            };
            this.messages.push(aiMsg);
            this.saveHistory(); // Save after AI response

        } catch (parseErr) {
           let errorMsg = (parseErr as BusinessError).message || '未知解析错误';
           
           // Truncate if too long
           if (rawResult.length > 500) {
               rawResult = rawResult.substring(0, 500) + '...';
           }

           const aiMsg: ChatMessage = {
            id: (new Date().getTime() + 1).toString(),
            role: 'assistant',
            content: `解析响应失败: ${errorMsg}\n\n可能原因：API地址错误或Key无效。\n\n原始响应片段: ${rawResult}`,
            timestamp: new Date().getTime()
          };
          this.messages.push(aiMsg);
        }
      } else {
        let errorMsg = `请求失败 (Code: ${response.responseCode})`;
        if (response.responseCode === 401) {
          errorMsg = 'API Key 无效或过期 (401)';
        } else if (response.responseCode === 404) {
          errorMsg = 'API 地址错误 (404)，请检查 Endpoint';
        } else if (response.responseCode === 500) {
          errorMsg = '服务器内部错误 (500)';
        } else if (response.responseCode === 503) {
          errorMsg = '服务暂时不可用 (503)，请稍后重试';
        }

        const aiMsg: ChatMessage = {
          id: (new Date().getTime() + 1).toString(),
          role: 'assistant',
          content: `${errorMsg}\n\n当前请求URL: ${url}\n\n请检查 API Key 和 Endpoint 配置。`,
          timestamp: new Date().getTime()
        };
        this.messages.push(aiMsg);
      }
    } catch (err) {
      let error = err as BusinessError;
      console.error(`Request Error: ${JSON.stringify(error)}`);
      
      let friendlyMsg = `发生错误: ${error.message || '网络连接失败'}`;
      if (error.message && error.message.includes('HTTP2')) {
          friendlyMsg = '网络协议错误 (HTTP2)，请尝试重新发送或更换网络。';
      } else if (error.message && (error.message.includes('failure when receiving data') || error.message.includes('timeout'))) {
          friendlyMsg = '网络连接超时，请检查网络设置。';
      } else if (error.message && error.message.includes('server returned nothing')) {
          friendlyMsg = '请求失败：服务器未返回数据。';
      }

      const aiMsg: ChatMessage = {
        id: (new Date().getTime() + 1).toString(),
        role: 'assistant',
        content: friendlyMsg,
        timestamp: new Date().getTime()
      };
      this.messages.push(aiMsg);
    } finally {
      this.isTyping = false;
      // Wait for UI to render then scroll
      setTimeout(() => {
        this.scroller.scrollEdge(Edge.Bottom);
      }, 100);
      httpRequest.destroy();
    }
  }
}
