import router from '@ohos.router';
import { QuizQuestion } from '../model/types';
import { QuestionRepository } from '../common/utils/QuestionRepository';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct QuizResult {
  @State score: number = 0;
  @State totalQuestions: number = 0;
  @State languageId: string = '';
  @State languageName: string = '';
  @State percentage: number = 0;
  @State customQuestions: QuizQuestion[] = [];
  @State isSaved: boolean = false;

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params) {
      this.score = params['score'] as number;
      this.totalQuestions = params['totalQuestions'] as number;
      this.languageId = params['languageId'] as string;
      this.languageName = params['languageName'] as string;
      if (params['customQuestions']) {
        this.customQuestions = params['customQuestions'] as QuizQuestion[];
      }
      
      if (this.totalQuestions > 0) {
        this.percentage = Math.round((this.score / this.totalQuestions) * 100);
      }
    }
  }

  async saveToBank() {
    if (this.customQuestions.length > 0) {
      try {
        await QuestionRepository.saveQuestions(this.customQuestions);
        this.isSaved = true;
        promptAction.showToast({ message: '题目已成功添加到题库！' });
      } catch (e) {
        promptAction.showToast({ message: '保存失败，请重试' });
      }
    }
  }

  getEvaluation(): string {
    if (this.percentage >= 90) return '太棒了！你是编程大师！🎉';
    if (this.percentage >= 80) return '干得漂亮！继续保持！💪';
    if (this.percentage >= 60) return '成绩不错，还有提升空间！📚';
    return '再接再厉，多做练习哦！🔥';
  }

  getEvaluationColor(): string {
    if (this.percentage >= 90) return '#52C41A';
    if (this.percentage >= 80) return '#1890FF';
    if (this.percentage >= 60) return '#FAAD14';
    return '#FF4D4F';
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('<')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            try {
              router.back({ url: 'pages/QuizHome' });
            } catch (err) {
              console.error(`Back failed: ${err}`);
            }
          })
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        
        Text('挑战结果')
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
        Column() {
          // Result Card
          Column() {
            // Language Badge
            Text(this.languageName)
              .fontSize(16)
              .fontColor('#666666')
              .backgroundColor('#F5F5F5')
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .borderRadius(20)
              .margin({ bottom: 24 })

            // Score Circle
            Stack({ alignContent: Alignment.Center }) {
              Progress({ value: this.percentage, total: 100, type: ProgressType.Ring })
                .width(200)
                .height(200)
                .color(this.getEvaluationColor())
                .backgroundColor('#F0F0F0')
                .style({ strokeWidth: 15 })
              
              Column() {
                Text(`${this.percentage}%`)
                  .fontSize(48)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.getEvaluationColor())
                
                Text(`得分: ${this.score}/${this.totalQuestions}`)
                  .fontSize(16)
                  .fontColor('#999999')
                  .margin({ top: 8 })
              }
            }
            .margin({ bottom: 32 })

            // Evaluation Text
            Text(this.getEvaluation())
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .textAlign(TextAlign.Center)
              .margin({ bottom: 40 })
              .width('80%')

            // Buttons
            if (this.customQuestions.length > 0 && !this.isSaved) {
              Button('保存到题库')
                .type(ButtonType.Capsule)
                .width('100%')
                .height(56)
                .backgroundColor('#52C41A')
                .margin({ bottom: 16 })
                .onClick(() => {
                  this.saveToBank();
                })
            }

            Button('再试一次')
              .type(ButtonType.Capsule)
              .width('100%')
              .height(56)
              .backgroundColor('#007DFF')
              .margin({ bottom: 16 })
              .onClick(() => {
                router.replaceUrl({
                  url: 'pages/QuizPage',
                  params: {
                    languageId: this.languageId,
                    languageName: this.languageName,
                    customQuestions: this.customQuestions
                  }
                });
              })

            Button('返回题库')
              .type(ButtonType.Normal)
              .width('100%')
              .height(56)
              .backgroundColor(Color.Transparent)
              .fontColor('#666666')
              .border({ width: 1, color: '#E8E8E8', radius: 28 })
              .onClick(() => {
                router.back({ url: 'pages/Index' });
              })

          }
          .width('100%')
          .padding(32)
          .backgroundColor(Color.White)
          .borderRadius(24)
          .shadow({ radius: 20, color: 'rgba(0,0,0,0.05)', offsetY: 10 })
        }
        .padding(24)
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}
