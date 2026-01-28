import router from '@ohos.router';
import http from '@ohos.net.http';
import { BusinessError } from '@ohos.base';
import { StorageUtil } from '../common/utils/StorageUtil';
import { QuizQuestion, ProgrammingLanguage } from '../model/types';
import { PROGRAMMING_LANGUAGES } from '../common/constants/MockData';

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
struct AIQuizGenerator {
  @State language: string = 'ArkTS';
  @State difficulty: string = 'Intermediate';
  @State topic: string = 'Basic Syntax';
  @State isGenerating: boolean = false;
  @State apiKey: string = '';
  @State apiEndpoint: string = '';
  @State modelName: string = '';
  @State statusMessage: string = '';

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

        Text('AI 出题')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#191919')
          .margin({ left: 16 })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12, bottom: 12 })

      Scroll() {
        Column() {
          Text('配置你的专属挑战')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 20, bottom: 8 })
            .width('100%')
          
          Text('利用 AI 为你生成定制化的编程测试题')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ bottom: 30 })
            .width('100%')

          // Form
          Column({ space: 20 }) {
            // Language Input
            Column() {
              Text('编程语言')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .margin({ bottom: 8 })
                .width('100%')
              
              TextInput({ text: this.language, placeholder: '例如: ArkTS, Python, Java' })
                .height(48)
                .width('100%')
                .borderRadius(12)
                .backgroundColor('#F5F7FA')
                .onChange((value: string) => {
                  this.language = value;
                })

              // Quick Select Chips
              Flex({ wrap: FlexWrap.Wrap }) {
                ForEach(PROGRAMMING_LANGUAGES, (item: ProgrammingLanguage) => {
                  Text(item.displayName)
                    .fontSize(12)
                    .fontColor(this.language.toLowerCase() === item.name.toLowerCase() ? '#1890FF' : '#666666')
                    .backgroundColor(this.language.toLowerCase() === item.name.toLowerCase() ? '#E6F7FF' : '#F5F7FA')
                    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                    .borderRadius(16)
                    .margin({ right: 8, bottom: 8 })
                    .border({ width: 1, color: this.language.toLowerCase() === item.name.toLowerCase() ? '#1890FF' : 'transparent' })
                    .onClick(() => {
                      this.language = item.name;
                    })
                })
              }
              .margin({ top: 12 })
            }

            // Difficulty Input
            Column() {
              Text('难度等级')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .margin({ bottom: 8 })
                .width('100%')
              
              Row({ space: 10 }) {
                this.DifficultyBadge('Beginner', '初级')
                this.DifficultyBadge('Intermediate', '中级')
                this.DifficultyBadge('Advanced', '高级')
              }
              .width('100%')
            }

            // Topic Input
            Column() {
              Text('特定主题 (可选)')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .margin({ bottom: 8 })
                .width('100%')
              
              TextInput({ text: this.topic, placeholder: '例如: 数组, 并发, 泛型' })
                .height(48)
                .width('100%')
                .borderRadius(12)
                .backgroundColor('#F5F7FA')
                .onChange((value: string) => {
                  this.topic = value;
                })
            }
          }
          .padding(20)
          .backgroundColor(Color.White)
          .borderRadius(16)
          .shadow({ radius: 10, color: 'rgba(0,0,0,0.03)', offsetY: 4 })
          .margin({ bottom: 30 })

          // Status Message
          if (this.statusMessage) {
            Text(this.statusMessage)
              .fontSize(14)
              .fontColor(this.statusMessage.includes('失败') || this.statusMessage.includes('错误') ? '#FF4D4F' : '#1890FF')
              .margin({ bottom: 20 })
              .textAlign(TextAlign.Center)
              .width('100%')
          }

          // Generate Button
          Button(this.isGenerating ? '正在生成题目...' : '开始生成题目')
            .width('100%')
            .height(56)
            .backgroundColor('#1890FF')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .enabled(!this.isGenerating)
            .opacity(this.isGenerating ? 0.7 : 1)
            .shadow({ radius: 10, color: 'rgba(24, 144, 255, 0.3)', offsetY: 4 })
            .onClick(() => {
              this.generateQuiz();
            })

        }
        .padding(20)
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }

  @Builder
  DifficultyBadge(value: string, label: string) {
    Text(label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.difficulty === value ? '#1890FF' : '#666666')
      .backgroundColor(this.difficulty === value ? '#E6F7FF' : '#F5F7FA')
      .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      .borderRadius(20)
      .border({ width: 1, color: this.difficulty === value ? '#1890FF' : 'transparent' })
      .onClick(() => {
        this.difficulty = value;
      })
  }

  async generateQuiz() {
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

    if (!this.language) {
      this.statusMessage = '请输入编程语言';
      return;
    }

    this.isGenerating = true;
    this.statusMessage = '正在连接 AI 模型...';

    const prompt = `
You are a professional programming quiz generator.
Generate 5 multiple-choice questions for ${this.language} (Difficulty: ${this.difficulty}) related to topic: "${this.topic}".

Format requirements:
1. Return ONLY a valid JSON array.
2. No markdown formatting (no \`\`\`json or \`\`\`).
3. No introductory or concluding text.
4. Each question object must strictly follow this TypeScript interface:
interface QuizQuestion {
  id: string; // generate a unique string id
  language: string; // "${this.language}"
  type: "single";
  question: string;
  options: string[]; // array of 4 distinct options
  correctAnswer: string; // must match exactly one of the options
  explanation: string; // brief explanation of the answer
  difficulty: number; // 1-5 based on selected difficulty
  tags: string[];
}

Ensure the questions are high quality and the correct answer is accurate.
`;

    let httpRequest = http.createHttp();
    
    // Construct URL logic reused from AIChat
    let endpoint = this.apiEndpoint.trim();
    while (endpoint.endsWith('/')) {
      endpoint = endpoint.slice(0, -1);
    }
    let url = endpoint;
    // Check for common patterns
    if (url.endsWith('/chat/completions')) {
       // already full path
    } else if (url.endsWith('/v1')) {
      url = `${endpoint}/chat/completions`;
    } else {
      // Try to guess: most providers need /v1/chat/completions
      // But if user provided a full path without v1, we should be careful.
      // Safest default for simple domains:
      url = `${endpoint}/v1/chat/completions`;
    }
    
    // Log the URL for debugging
    console.info('AI Quiz Generator Request URL:', url);

    const apiMessage = new ApiMessage();
    apiMessage.role = 'user';
    apiMessage.content = prompt;

    let requestBody = new ChatRequest();
    requestBody.model = this.modelName || 'gpt-3.5-turbo';
    requestBody.messages = [apiMessage];
    requestBody.temperature = 0.5; // Lower temperature for more deterministic output

    try {
      this.statusMessage = 'AI 正在思考题目...';
      const response = await httpRequest.request(url, {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${this.apiKey}`
        },
        extraData: JSON.stringify(requestBody),
        expectDataType: http.HttpDataType.STRING,
        readTimeout: 60000,
        connectTimeout: 60000, // Add explicit connect timeout
        usingProtocol: http.HttpProtocol.HTTP1_1
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
          this.statusMessage = '解析题目数据...';
          const questions = this.parseQuestions(content);
          if (questions.length > 0) {
             // Navigate to QuizPage
             router.pushUrl({
               url: 'pages/QuizPage',
               params: {
                 customQuestions: questions,
                 languageId: 'ai_generated',
                 languageName: `AI: ${this.language} (${this.difficulty})`
               }
             });
             this.statusMessage = '';
          } else {
            this.statusMessage = '生成的格式无法解析，请重试';
            console.error('Failed to parse questions from content:', content);
          }
        } else {
          this.statusMessage = 'AI 没有返回内容';
        }
      } else {
        this.statusMessage = `请求失败: ${response.responseCode}`;
      }
    } catch (err) {
      this.statusMessage = `发生错误: ${(err as BusinessError).message}`;
      console.error('AI Generate Error:', err);
    } finally {
      this.isGenerating = false;
      httpRequest.destroy();
    }
  }

  parseQuestions(content: string): QuizQuestion[] {
    try {
      // Clean up markdown if present despite instructions
      let jsonStr = content.trim();
      if (jsonStr.startsWith('```json')) {
        jsonStr = jsonStr.substring(7);
      } else if (jsonStr.startsWith('```')) {
        jsonStr = jsonStr.substring(3);
      }
      if (jsonStr.endsWith('```')) {
        jsonStr = jsonStr.substring(0, jsonStr.length - 3);
      }
      
      const parsed = JSON.parse(jsonStr) as QuizQuestion[];
      if (Array.isArray(parsed)) {
        return parsed;
      }
      return [];
    } catch (e) {
      console.error('JSON Parse Error:', e);
      return [];
    }
  }
}
