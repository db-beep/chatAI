import router from '@ohos.router';
import { MistakeRecord } from '../model/types';
import { StorageUtil } from '../common/utils/StorageUtil';

@Component
export struct MistakeBook {
  @State mistakes: MistakeRecord[] = [];

  async aboutToAppear() {
    await this.loadMistakes();
  }

  async loadMistakes() {
    const jsonStr = await StorageUtil.getInstance().get('mistake_records', '[]') as string;
    try {
      this.mistakes = JSON.parse(jsonStr);
      // Sort by timestamp descending (newest first)
      this.mistakes.sort((a, b) => b.timestamp - a.timestamp);
    } catch (e) {
      console.error('Failed to parse mistakes', e);
      this.mistakes = [];
    }
  }

  async deleteMistake(id: string) {
    this.mistakes = this.mistakes.filter(m => m.id !== id);
    await StorageUtil.getInstance().put('mistake_records', JSON.stringify(this.mistakes));
  }

  @Builder
  DeleteAction(record: MistakeRecord) {
    Button('删除')
      .type(ButtonType.Normal)
      .width(80)
      .height('100%')
      .backgroundColor('#FF4D4F')
      .fontColor(Color.White)
      .onClick(() => {
        this.deleteMistake(record.id);
      })
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('错题回顾')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .height(56)
      .width('100%')
      .backgroundColor(Color.White)
      .shadow({ radius: 2, offsetY: 1, color: '#F0F0F0' })

      if (this.mistakes.length > 0) {
        List({ space: 12 }) {
          ForEach(this.mistakes, (item: MistakeRecord) => {
            ListItem() {
              this.MistakeCard(item)
            }
            .swipeAction({ end: () => this.DeleteAction(item) })
            .clip(true)
            .borderRadius(16)
          }, (item: MistakeRecord) => item.id)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .backgroundColor('#F7F8FA')
      } else {
        Column() {
          Image($r('app.media.startIcon'))
            .width(64)
            .height(64)
            .opacity(0.3)
            .margin({ bottom: 16 })
          Text('太棒了，暂无错题！')
            .fontSize(16)
            .fontColor('#969799')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F7F8FA')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F8FA')
  }

  @Builder
  MistakeCard(record: MistakeRecord) {
    Column() {
      Row() {
        Text(this.getLanguageName(record.languageId))
          .fontSize(12)
          .fontColor('#1989FA')
          .backgroundColor('#E6F7FF')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(4)
        
        Blank()

        Text(new Date(record.timestamp).toLocaleDateString())
          .fontSize(12)
          .fontColor('#969799')
      }
      .width('100%')
      .margin({ bottom: 12 })

      Text(record.question)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#323233')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: 16 })

      // Answer Comparison
      Row() {
        Column() {
          Text('您的答案')
            .fontSize(12)
            .fontColor('#FF4D4F')
            .margin({ bottom: 4 })
          Text(record.wrongAnswer)
            .fontSize(14)
            .fontColor('#333333')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Divider()
          .vertical(true)
          .height(30)
          .margin({ left: 12, right: 12 })

        Column() {
          Text('正确答案')
            .fontSize(12)
            .fontColor('#52C41A')
            .margin({ bottom: 4 })
          Text(record.correctAnswer)
            .fontSize(14)
            .fontColor('#333333')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .backgroundColor('#F9FAFB')
      .padding(12)
      .borderRadius(8)
      .width('100%')
      .margin({ bottom: 12 })

      // Explanation
      Text('解析：' + record.explanation)
        .fontSize(13)
        .fontColor('#666666')
        .lineHeight(20)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .padding(16)
  }

  getLanguageName(id: string): string {
    const map: Record<string, string> = {
      'arkts': 'ArkTS',
      'cangjie': '仓颉',
      'java': 'Java',
      'python': 'Python',
      'cpp': 'C++',
      'javascript': 'JavaScript',
      'typescript': 'TypeScript',
      'go': 'Go',
      'rust': 'Rust',
      'swift': 'Swift',
      'kotlin': 'Kotlin'
    };
    return map[id] || id;
  }
}
