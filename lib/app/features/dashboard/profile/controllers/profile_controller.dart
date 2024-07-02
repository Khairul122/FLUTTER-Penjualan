import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ProfileController extends GetxController {
  // Observable variables to store the user data
  var namaPengguna = ''.obs;
  var email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method to fetch user data from Hive
  void fetchUserData() async {
    var box = await Hive.openBox('userBox');
    var userData = box.get('user');
    if (userData != null) {
      namaPengguna.value = userData['nama_pengguna'];
      email.value = userData['email'];
    }
  }
}
