library landing;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:marketplace/app/shared_components/custom_button.dart';

part "../controllers/landing_controller.dart";
part "../bindings/landing_binding.dart";

class LandingScreen extends GetView<LandingController> {
  const LandingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(25.0.sp),
        height: 1.sh,
        width: 1.sw,
        color: Colors.white,
        child: Wrap(
          // crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 1.sw,
              // height: 150.h,
              child: Image.asset(
                "assets/images/logo.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 1.h,
                  width: 0.25.sw,
                  color: Color(0xFFBA704F),
                ),
                Text(
                  "Mulai dengan",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Color(0xFFBA704F),
                  ),
                ),
                Container(
                  height: 1.h,
                  width: 0.25.sw,
                  color: Color(0xFFBA704F),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                    width: 1.sw,
                    child: CustomButton(
                      label: "Login",
                      onTap: () {
                        Get.toNamed("/login");
                      },
                      textColor: Colors.white,
                    )),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                    width: 1.sw,
                    child: CustomButton(
                      label: "Register",
                      onTap: () {
                        Get.toNamed("/register");
                      },
                      textColor: Colors.white,
                    )),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "By continue you agree to our",
                  style: TextStyle(color: Colors.black, fontSize: 10.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Term  & Privacy Policy",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
