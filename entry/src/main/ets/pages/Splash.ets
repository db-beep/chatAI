import router from '@ohos.router';

@Entry
@Component
struct Splash {
  aboutToAppear() {
    setTimeout(() => {
      router.replaceUrl({ url: 'pages/Index' });
    }, 1500);
  }

  build() {
    Stack() {
      Image($r('app.media.first'))
        .objectFit(ImageFit.Cover)
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
