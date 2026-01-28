import router from '@ohos.router';
import { PROGRAMMING_LANGUAGES } from '../common/constants/MockData';
import { ProgrammingLanguage } from '../model/types';
import { StorageUtil } from '../common/utils/StorageUtil';
import { QuestionRepository } from '../common/utils/QuestionRepository';

@Component
export struct QuizHome {
  @State languages: ProgrammingLanguage[] = PROGRAMMING_LANGUAGES;
  @State progressMap: Map<string, number> = new Map();
  @StorageProp('shouldRefreshQuiz') @Watch('onTriggerChange') trigger: number = 0;

  async aboutToAppear() {
    await this.loadProgress();
  }

  onTriggerChange() {
    this.loadProgress();
  }

  async loadProgress() {
    for (const lang of this.languages) {
      // Get all questions (Mock + Custom)
      const questions = await QuestionRepository.getQuestionsByLanguage(lang.id);
      const total = questions.length;
      
      if (total === 0) {
        this.progressMap.set(lang.id, 0);
        continue;
      }

      const key = `completed_questions_${lang.id}`;
      const jsonStr = await StorageUtil.getInstance().get(key, '[]') as string;
      let completedIds: string[] = [];
      try {
        completedIds = JSON.parse(jsonStr);
      } catch (e) {
        completedIds = [];
      }
      
      const progress = Math.round((completedIds.length / total) * 100);
      this.progressMap.set(lang.id, progress);
    }
    // Trigger update
    this.progressMap = new Map(this.progressMap);
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('挑战语言')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .height(56)
      .width('100%')
      .backgroundColor(Color.White)
      .shadow({ radius: 2, offsetY: 1, color: '#F0F0F0' })

      Scroll() {
        Column() {
          // Feature Cards
          Row() {
            // AI Quiz Generator
            Column() {
              Image('https://img.icons8.com/fluency/96/artificial-intelligence.png')
                .width(48)
                .height(48)
                .objectFit(ImageFit.Contain)
                .margin({ bottom: 12 })
              Text('AI 出题')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#191919')
                .margin({ bottom: 4 })
              Text('定制题目')
                .fontSize(12)
                .fontColor('#999999')
            }
            .layoutWeight(1)
            .height(140)
            .backgroundColor(Color.White)
            .borderRadius(20)
            .padding(16)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .shadow({ radius: 10, color: 'rgba(0,0,0,0.03)', offsetY: 4 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/AIQuizGenerator' });
            })
    
            Blank().width(12)
    
            // AI Learning
            Column() {
              Image('https://img.icons8.com/fluency/96/teacher.png')
                .width(48)
                .height(48)
                .objectFit(ImageFit.Contain)
                .margin({ bottom: 12 })
              Text('AI 导师')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#191919')
                .margin({ bottom: 4 })
              Text('答疑解惑')
                .fontSize(12)
                .fontColor('#999999')
            }
            .layoutWeight(1)
            .height(140)
            .backgroundColor(Color.White)
            .borderRadius(20)
            .padding(16)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .shadow({ radius: 10, color: 'rgba(0,0,0,0.03)', offsetY: 4 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/AILearning' });
            })
          }
          .padding({ left: 20, right: 20, bottom: 20, top: 20 })
          .width('100%')
    
          Text('语言列表')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#191919')
            .margin({ left: 24, bottom: 12 })
            .width('100%')
    
          // Language Grid
          Grid() {
            ForEach(this.languages, (item: ProgrammingLanguage) => {
              GridItem() {
                Column() {
                  Row() {
                    // Icon Area
                    Row() {
                      Image(item.icon)
                        .width(24)
                        .height(24)
                    }
                    .width(44)
                    .height(44)
                    .borderRadius(12)
                    .backgroundColor('#F5F7FA')
                    .justifyContent(FlexAlign.Center)
                    .margin({ right: 12 })
    
                    Column() {
                      Text(item.displayName)
                        .fontSize(16)
                        .fontWeight(FontWeight.Bold)
                        .fontColor('#191919')
                      
                      Text(`${this.progressMap.get(item.id) || 0}% 完成`)
                        .fontSize(12)
                        .fontColor('#999999')
                        .margin({ top: 2 })
                    }
                    .alignItems(HorizontalAlign.Start)
                  }
                  .width('100%')
                  .margin({ bottom: 16 })
    
                  // Progress Bar
                  Progress({ 
                    value: this.progressMap.get(item.id) || 0, 
                    total: 100, 
                    type: ProgressType.Linear 
                  })
                  .color('#007DFF')
                  .backgroundColor('#F0F0F0')
                  .height(4)
                  .width('100%')
                  
                  Row() {
                     Text(item.difficulty === 'beginner' ? '初级' : (item.difficulty === 'intermediate' ? '中级' : '高级'))
                       .fontSize(10)
                       .fontColor('#999999')
                       .margin({ top: 8 })
                     
                     Blank()
                     
                     Button('开始')
                       .type(ButtonType.Normal)
                       .fontSize(12)
                       .fontColor(Color.White)
                       .backgroundColor('#1890FF')
                       .borderRadius(14)
                       .padding({ left: 12, right: 12, top: 4, bottom: 4 })
                       .height(28)
                       .margin({ top: 8 })
                       .onClick(() => {
                         router.pushUrl({
                            url: 'pages/QuizPage',
                            params: {
                              languageId: item.id,
                              languageName: item.displayName
                            }
                          });
                       })
                  }
                  .width('100%')
                  .alignItems(VerticalAlign.Center)
                }
                .width('100%')
                .height(140)
                .backgroundColor(Color.White)
                .borderRadius(20)
                .padding(16)
                .alignItems(HorizontalAlign.Start)
                .shadow({ radius: 8, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/QuizPage',
                    params: {
                      languageId: item.id,
                      languageName: item.displayName
                    }
                  });
                })
              }
            }, (item: ProgrammingLanguage) => item.id)
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(12)
          .columnsGap(12)
          .padding({ left: 20, right: 20, bottom: 20 })
          .height(500) // Grid needs height or layout weight
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }

  getDifficultyColor(difficulty: string): string {
    switch (difficulty) {
      case 'beginner': return '#52C41A';
      case 'intermediate': return '#1890FF';
      case 'advanced': return '#F5222D';
      default: return '#888888';
    }
  }

  getDifficultyBgColor(difficulty: string): string {
    switch (difficulty) {
      case 'beginner': return '#F6FFED';
      case 'intermediate': return '#E6F7FF';
      case 'advanced': return '#FFF1F0';
      default: return '#F5F5F5';
    }
  }
}
