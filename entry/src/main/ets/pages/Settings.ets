import router from '@ohos.router';

@Component
export struct Settings {
  build() {
    Column() {
      // Header
      Row() {
        Text('设置')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .height(56)
      .width('100%')
      .backgroundColor(Color.White)
      .shadow({ radius: 2, offsetY: 1, color: '#F0F0F0' })

      
      // Settings List
      Column() {
        List() {
          ListItem() {
            Row() {
              Text('AI 模型配置')
                .fontSize(16)
                .fontColor('#333333')
              Blank()
              Text('>')
                .fontSize(16)
                .fontColor('#999999')
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .onClick(() => {
              router.pushUrl({ url: 'pages/AIConfig' });
            })
          }
        }
        .width('100%')
        .margin({ top: 16 })

        // About Us Info (Always Visible)
        Column() {
          Image($r('app.media.image_icon'))
            .width(100)
            .height(100)
            .margin({ bottom: 20 })
            .borderRadius(20)
          
          Text('ChatAI')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 10 })
          
          Text('Version 1.0.0')
            .fontSize(18)
            .fontColor('#999999')
            .margin({ bottom: 30 })
          
          Column({ space: 10 }) {
            this.InfoRow('开发人员', 'HB')
            this.InfoRow('联系方式', 'hb201103@foxmail.com')
            this.InfoRow('官方网站', 'github.com/db-beep')
            this.InfoRow('版权所有', '© 2025 ChatAI-HB Inc.')
          }
          .width('100%')
          .padding(24)
          .backgroundColor(Color.White)
          .borderRadius(16)
        }
        .width('100%')
        .padding({ left: 10, right: 20, bottom: 40, top: 30 })
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F7FA')
  }

  @Builder
  InfoRow(label: string, value: string) {
    Column() {
      Row() {
        Text(label)
          .fontSize(16)
          .fontColor('#666666')
          .width(80) // Fixed width for alignment
        
        Text(value)
          .fontSize(16)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1) // Take remaining space
          .textAlign(TextAlign.End) // Align right
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .width('100%')
      .alignItems(VerticalAlign.Top) // Align top for multi-line
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .border({ width: { bottom: 1 }, color: '#F0F0F0' })
  }
}
