library profile;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:marketplace/app/shared_components/custom_button.dart';
import 'package:marketplace/app/shared_components/input_field.dart';

part "../controllers/profile_controller.dart";
part "../bindings/profile_binding.dart";

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profil',
            style: TextStyle(fontSize: 12.sp),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            height: 1.sh,
            width: 1.sw,
            padding: EdgeInsets.all(25.0.sp),
            color: Colors.white,
            child: Wrap(
              runSpacing: 15.sp,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: 200.r,
                  height: 200.r,
                  child: Image.asset(
                    "assets/images/logo.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    InputField(
                        label: "Nama Pengguna",
                        controller: controller.namaPengguna),
                    SizedBox(
                      height: 15.sp,
                    ),
                    InputField(label: "Email", controller: controller.email),
                  ],
                ),
                SizedBox(
                    width: 1.sw,
                    child: CustomButton(
                      label: "Logout",
                      onTap: () {
                        Get.back();
                        Get.offAndToNamed("/login");
                        // Get.toNamed("/login");
                      },
                      textColor: Colors.white,
                    )),
              ],
            ),
          ),
        ));
  }
}
