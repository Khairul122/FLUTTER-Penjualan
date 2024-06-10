import 'package:get/get.dart';
import 'package:marketplace/app/features/authentication/index/controllers/login_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
