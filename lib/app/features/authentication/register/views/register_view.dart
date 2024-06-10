import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marketplace/app/shared_components/custom_button.dart';
import 'package:marketplace/app/shared_components/input_field.dart';
import '../controllers/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: 1.sw,
            padding: EdgeInsets.all(25.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SIGN UP",
                      style: TextStyle(
                        fontSize: 26.sp,
                        color: Color(0xFFBA704F),
                      ),
                    ),
                    SizedBox(
                      width: 150.w,
                      child: Image.asset(
                        "assets/images/logo.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.sp),
                InputField(label: "Nama Pengguna", controller: controller.namaPengguna),
                SizedBox(height: 15.sp),
                InputField(label: "Email", controller: controller.email),
                SizedBox(height: 15.sp),
                InputField(label: "Password", controller: controller.password),
                SizedBox(height: 15.sp),
                Obx(() {
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Alamat",
                      border: OutlineInputBorder(),
                    ),
                    value: controller.selectedAlamat.value.isEmpty ? null : controller.selectedAlamat.value,
                    items: [
                      DropdownMenuItem(
                        value: '',
                        child: Text('Pilih Alamat'),
                      ),
                      ...controller.alamatList.map<DropdownMenuItem<String>>((Map<String, dynamic> data) {
                        return DropdownMenuItem<String>(
                          value: data['id_alamat'],
                          child: Text('${data['alamat']}'),
                        );
                      }).toList(),
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null && newValue.isNotEmpty) {
                        controller.selectedAlamat.value = newValue;
                      }
                    },
                  );
                }),
                SizedBox(height: 15.sp),
                InputField(label: "No. Telepon", controller: controller.noTelepon),
                SizedBox(height: 25.sp),
                SizedBox(
                  width: 1.sw,
                  child: CustomButton(
                    label: "Register",
                    onTap: () {
                      controller.register();
                    },
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 15.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
