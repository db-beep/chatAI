import { StorageUtil } from '../common/utils/StorageUtil';
import common from '@ohos.app.ability.common';
import { AIChat } from './AIChat';
import { QuizHome } from './QuizHome';
import { MistakeBook } from './MistakeBook';
import { Settings } from './Settings';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private controller: TabsController = new TabsController();

  async aboutToAppear() {
    let context = getContext(this) as common.UIAbilityContext;
    await StorageUtil.getInstance().init(context);
  }

  onPageShow() {
    // Notify child components to refresh
    AppStorage.SetOrCreate('shouldRefreshQuiz', Date.now());
  }

  @Builder
  TabBuilder(title: string, targetIndex: number, selectedImg: string, normalImg: string) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 24, height: 24 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1890FF' : '#666666')
        .fontSize(10)
        .margin({ top: 4 })
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.controller.changeIndex(this.currentIndex);
    })
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
        TabContent() {
          QuizHome()
        }
        .tabBar(this.TabBuilder('编程答题', 0, 'https://img.icons8.com/fluency/96/exam.png', 'https://img.icons8.com/fluency/96/exam.png'))

        TabContent() {
          AIChat()
        }
        .tabBar(this.TabBuilder('AI 助手', 1, 'https://img.icons8.com/fluency/96/bot.png', 'https://img.icons8.com/fluency/96/bot.png'))

        TabContent() {
          MistakeBook()
        }
        .tabBar(this.TabBuilder('错题回顾', 2, 'https://img.icons8.com/fluency/96/bookmark-ribbon.png', 'https://img.icons8.com/fluency/96/bookmark-ribbon.png'))

        TabContent() {
          Settings()
        }
        .tabBar(this.TabBuilder('设置', 3, 'https://img.icons8.com/fluency/96/settings.png', 'https://img.icons8.com/fluency/96/settings.png'))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth('100%')
      .barHeight(56)
      .animationDuration(200)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
    }
    .width('100%')
    .height('100%')
  }
}
