library splash;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

part '../controllers/splash_screen_controller.dart';
part '../bindings/splash_screen_binding.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1.sw,
          height: 0.5.sh,
          child: Image.asset(
            "assets/images/logo.jpeg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
