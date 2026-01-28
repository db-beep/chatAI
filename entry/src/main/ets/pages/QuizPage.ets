import router from '@ohos.router';
import { MOCK_QUESTIONS } from '../common/constants/MockData';
import { QuizQuestion, MistakeRecord } from '../model/types';
import { StorageUtil } from '../common/utils/StorageUtil';
import { QuestionRepository } from '../common/utils/QuestionRepository';

@Entry
@Component
struct QuizPage {
  @State languageId: string = '';
  @State languageName: string = '';
  @State questions: QuizQuestion[] = [];
  @State currentIndex: number = 0;
  @State selectedOption: string = '';
  @State showResult: boolean = false;
  @State isCorrect: boolean = false;
  @State score: number = 0;

  async aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params) {
      this.languageId = params['languageId'] as string;
      this.languageName = params['languageName'] as string;
      
      if (params['customQuestions']) {
        this.questions = params['customQuestions'] as QuizQuestion[];
      } else {
        // Use QuestionRepository to load ALL questions (Mock + Saved)
        const allQuestions = await QuestionRepository.getQuestionsByLanguage(this.languageId);
        this.questions = allQuestions;
      }
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('<')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .onClick(() => router.back())
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        
        Text(this.languageName)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        Text(`得分: ${this.score}`)
          .fontSize(16)
          .fontColor('#007DFF')
          .margin({ right: 16 })
      }
      .height(56)
      .width('100%')
      .backgroundColor(Color.White)
      .shadow({ radius: 2, offsetY: 1, color: '#F0F0F0' })

      // Progress Bar
      if (this.questions.length > 0) {
        Progress({ value: this.currentIndex + 1, total: this.questions.length, type: ProgressType.Linear })
          .color('#007DFF')
          .backgroundColor('#F0F0F0')
          .width('100%')
          .height(6) // Thicker
      }

      if (this.questions.length > 0) {
        Scroll() {
          Column() {
            // Question Counter
            Text(`Question ${this.currentIndex + 1} of ${this.questions.length}`)
              .fontSize(14)
              .fontColor('#999999')
              .margin({ bottom: 12 })
              .width('100%')

            // Question Text
            Text(this.questions[this.currentIndex].question)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .lineHeight(28)
              .margin({ bottom: 24 })
              .width('100%')
            
            // Code Snippet (if any)
            if (this.questions[this.currentIndex].code) {
              Text(this.questions[this.currentIndex].code)
                .fontFamily('monospace')
                .fontSize(14)
                .fontColor('#333333')
                .backgroundColor('#F5F7FA')
                .padding(16)
                .borderRadius(12)
                .width('100%')
                .margin({ bottom: 24 })
                .border({ width: 1, color: '#E8E8E8' })
            }

            // Options
            if (this.questions[this.currentIndex].options) {
              Column({ space: 12 }) {
                ForEach(this.questions[this.currentIndex].options, (option: string, index: number) => {
                  this.OptionCard(option, index)
                })
              }
              .width('100%')
            }

            // Result Feedback
            if (this.showResult) {
              Column() {
                Row() {
                  Image($r('app.media.image_icon'))
                    .width(24)
                    .height(24)
                    .fillColor(this.isCorrect ? '#52C41A' : '#FF4D4F')
                    .margin({ right: 8 })
                  Text(this.isCorrect ? '回答正确！' : '回答错误')
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(this.isCorrect ? '#52C41A' : '#FF4D4F')
                }
                .margin({ bottom: 12 })
                
                Text(this.questions[this.currentIndex].explanation)
                  .fontSize(15)
                  .fontColor('#666666')
                  .lineHeight(24)
              }
              .width('100%')
              .margin({ top: 24 })
              .padding(20)
              .backgroundColor(this.isCorrect ? '#F6FFED' : '#FFF1F0')
              .borderRadius(16)
              .border({ width: 1, color: this.isCorrect ? '#B7EB8F' : '#FFA39E' })
            }

            // Action Button
            if (this.showResult) {
              Button(this.getButtonText())
                .type(ButtonType.Capsule)
                .width('100%')
                .height(56)
                .backgroundColor('#007DFF')
                .margin({ top: 40, bottom: 20 })
                .onClick(() => {
                  this.handleButtonClick();
                })
            }

            // Show Answer Button
            if (!this.showResult) {
              Button('查看答案')
                .type(ButtonType.Normal)
                .width('100%')
                .height(56)
                .backgroundColor(Color.Transparent)
                .fontColor('#1890FF')
                .border({ width: 1, color: '#1890FF', radius: 28 })
                .margin({ bottom: 20 })
                .onClick(() => {
                  this.handleShowAnswer();
                })
            }
          }
          .padding(24)
        }
        .layoutWeight(1)
      } else {
        Column() {
          Image($r('app.media.image_icon'))
            .width(64)
            .height(64)
            .opacity(0.3)
            .margin({ bottom: 16 })
          Text('暂无题目')
            .fontSize(18)
            .fontColor('#999999')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  OptionCard(option: string, index: number) {
    Row() {
      // Radio Indicator
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 24, height: 24 })
          .stroke(this.getOptionBorderColor(option))
          .strokeWidth(2)
          .fill(Color.Transparent)
        
        if (this.selectedOption === option) {
          Circle({ width: 12, height: 12 })
            .fill(this.getOptionColor(option))
        }
      }
      .margin({ right: 16 })

      Text(option)
        .fontSize(16)
        .fontColor(this.getOptionTextColor(option))
        .layoutWeight(1)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(this.getOptionBgColor(option))
    .borderRadius(16)
    .border({ width: 2, color: this.getOptionBorderColor(option) })
    .onClick(() => {
      if (!this.showResult) {
        this.selectedOption = option;
        this.checkAnswer(); // Immediately check answer upon selection
      }
    })
    .animation({ duration: 200 })
  }

  getOptionColor(option: string): string {
    if (this.showResult) {
      if (option === this.questions[this.currentIndex].correctAnswer) return '#52C41A';
      if (option === this.selectedOption && !this.isCorrect) return '#FF4D4F';
    }
    return '#1890FF';
  }

  getOptionTextColor(option: string): string {
    if (this.showResult) {
      if (option === this.questions[this.currentIndex].correctAnswer) return '#52C41A';
      if (option === this.selectedOption && !this.isCorrect) return '#FF4D4F';
    }
    return this.selectedOption === option ? '#1890FF' : '#333333';
  }

  getOptionBgColor(option: string): string {
    if (this.showResult) {
      if (option === this.questions[this.currentIndex].correctAnswer) return '#F6FFED';
      if (option === this.selectedOption && !this.isCorrect) return '#FFF1F0';
    }
    return this.selectedOption === option ? '#E6F7FF' : '#F9FAFB';
  }

  getOptionBorderColor(option: string): string {
    if (this.showResult) {
      if (option === this.questions[this.currentIndex].correctAnswer) return '#52C41A';
      if (option === this.selectedOption && !this.isCorrect) return '#FF4D4F';
    }
    return this.selectedOption === option ? '#1890FF' : 'transparent';
  }

  getButtonText(): string {
    if (!this.showResult) return '请选择答案'; // Placeholder, though button might be disabled or hidden
    if (this.currentIndex < this.questions.length - 1) return '下一题';
    return '完成挑战';
  }

  async checkAnswer() {
    if (!this.selectedOption) return;
    
    this.isCorrect = this.selectedOption === this.questions[this.currentIndex].correctAnswer;
    if (this.isCorrect) {
      this.score++;
      await this.saveProgress();
    } else {
      // Save mistake
      await this.saveMistake();
    }
    this.showResult = true;
  }

  async handleButtonClick() {
    if (!this.showResult) return; // Should not happen if button is disabled

    if (this.currentIndex < this.questions.length - 1) {
      this.currentIndex++;
      this.selectedOption = '';
      this.showResult = false;
    } else {
      try {
        router.replaceUrl({
          url: 'pages/QuizResult',
          params: {
            score: this.score,
            totalQuestions: this.questions.length,
            languageId: this.languageId,
            languageName: this.languageName,
            customQuestions: this.questions
          }
        });
      } catch (err) {
        console.error(`Nav failed: ${err}`);
      }
    }
  }

  async handleShowAnswer() {
    this.selectedOption = ''; // No option selected
    this.isCorrect = false; // Viewed answer counts as wrong
    await this.saveMistake(); // Add to mistake book
    this.showResult = true; // Reveal the result
  }

  async saveProgress() {
    try {
      const currentQ = this.questions[this.currentIndex];
      const key = `completed_questions_${this.languageId}`;
      const jsonStr = await StorageUtil.getInstance().get(key, '[]') as string;
      let completedIds: string[] = [];
      try {
        completedIds = JSON.parse(jsonStr);
      } catch (e) {
        completedIds = [];
      }
      
      if (!completedIds.includes(currentQ.id)) {
        completedIds.push(currentQ.id);
        await StorageUtil.getInstance().put(key, JSON.stringify(completedIds));
        console.info(`Progress saved for ${this.languageId}: ${currentQ.id}`);
      }
    } catch (err) {
      console.error('Failed to save progress', err);
    }
  }

  async saveMistake() {
    try {
      const currentQ = this.questions[this.currentIndex];
      const correctAns = Array.isArray(currentQ.correctAnswer) ? currentQ.correctAnswer.join(', ') : currentQ.correctAnswer;
      
      const record: MistakeRecord = {
        id: `${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
        questionId: currentQ.id,
        languageId: currentQ.language,
        question: currentQ.question,
        wrongAnswer: this.selectedOption,
        correctAnswer: correctAns,
        explanation: currentQ.explanation,
        timestamp: Date.now()
      };

      const jsonStr = await StorageUtil.getInstance().get('mistake_records', '[]') as string;
      let mistakes: MistakeRecord[] = [];
      try {
        mistakes = JSON.parse(jsonStr);
      } catch (e) {
        mistakes = [];
      }
      
      // Avoid duplicates for the same question
      const existsIndex = mistakes.findIndex(m => m.questionId === record.questionId);
      if (existsIndex !== -1) {
        // Update existing mistake
        mistakes[existsIndex] = record;
      } else {
        mistakes.push(record);
      }
      
      await StorageUtil.getInstance().put('mistake_records', JSON.stringify(mistakes));
      console.info('Mistake saved');
    } catch (err) {
      console.error('Failed to save mistake', err);
    }
  }
}
