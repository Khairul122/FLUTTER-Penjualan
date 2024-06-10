part of splash;

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  @override
  void onInit() {
    // print('run');
    Future.delayed(Duration(seconds: 3), () {
      // print('run1');
      Get.back();
      Get.offAndToNamed("/landing-page");
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
