import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';

class LoginController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void login() async {
    final url = 'http://10.0.2.2/backend-penjualan/PenggunaAPI.php'; // Ganti dengan URL API yang sesuai
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'action': 'login',
          'email': username.text,
          'password': password.text,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          var box = await Hive.openBox('userBox');
          box.put('user', responseData['user']);
          
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('Berhasil Masuk'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                      Get.offNamed("/dashboard");
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );

          print('Login successful: ${responseData['user']}');

          // Menampilkan data pengguna dari Hive di console
          var userData = box.get('user');
          print('User data from Hive: $userData');
        } else {
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(responseData['message']),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
          print('Login error: ${responseData['message']}');
        }
      } else {
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to login'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        print('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print('Error: $e');
    }
  }
}
