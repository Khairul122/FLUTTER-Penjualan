import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marketplace/app/features/dashboard/profile/controllers/profile_controller.dart';

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
        child: Center(
          child: Container(
            padding: EdgeInsets.all(25.0.sp),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Profile picture with overlay badge
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: AssetImage("assets/images/logo.jpeg"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 20.r,
                        height: 20.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                          border: Border.all(color: Colors.white, width: 2.0),
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.sp),
                // User name and email
                Obx(() => Text(
                  controller.namaPengguna.value,
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                )),
                Obx(() => Text(
                  controller.email.value,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
