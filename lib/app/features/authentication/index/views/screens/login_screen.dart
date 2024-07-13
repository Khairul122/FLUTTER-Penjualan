import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marketplace/app/shared_components/custom_button.dart';
import 'package:marketplace/app/shared_components/input_field.dart';
import '../../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 1.sh,
          padding: EdgeInsets.all(25.0.sp),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 1.sw,
                height: 250.h,
                child: Image.asset(
                  "assets/images/logo.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  InputField(label: "Email", controller: controller.username),
                  SizedBox(
                    height: 15.sp,
                  ),
                  InputField(
                      label: "Kata Sandi", controller: controller.password),
                ],
              ),
              SizedBox(
                height: 15.sp,
              ),
              Column(
                children: [
                  SizedBox(
                    width: 1.sw,
                    child: CustomButton(
                      label: "Masuk",
                      onTap: () {
                        controller.login();
                      },
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Wrap(
                    spacing: 5.sp,
                    children: [
                      Text(
                        "Belum punya akun?",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.toNamed("/register"),
                        child: Text(
                          "Daftar",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Color(0xFFBA704F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
