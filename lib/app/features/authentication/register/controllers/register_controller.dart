import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterController extends GetxController {
  TextEditingController namaPengguna = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController noTelepon = TextEditingController();

  var selectedAlamat = ''.obs;
  var alamatList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAlamatList();
  }

  void fetchAlamatList() async {
    final url = 'http://10.0.2.2/backend-penjualan/AlamatAPI.php';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        alamatList.value = responseData.map((data) => {
          'id_alamat': data['id_alamat'].toString(),
          'alamat': data['alamat'].toString(),
          'ongkir': data['ongkir'].toString()
        }).toList();
        if (alamatList.isNotEmpty) {
          selectedAlamat.value = alamatList.first['id_alamat'];
        }
        print("Alamat List: $alamatList");  // Print data yang diambil
      } else {
        print('Failed to load addresses: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching addresses: $e');
    }
  }

  void register() async {
    final url = 'http://10.0.2.2/backend-penjualan/PenggunaAPI.php';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'action': 'register',
          'nama_pengguna': namaPengguna.text,
          'email': email.text,
          'password': password.text,
          'id_alamat': selectedAlamat.value,
          'no_telepon': noTelepon.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          Get.dialog(
            AlertDialog(
              title: Text('Success'),
              content: Text('Berhasil Daftar'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.toNamed("/login");
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
          print('Registration successful: ${responseData['id_pengguna']}');
        } else {
          Get.dialog(
            AlertDialog(
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
            ),
          );
          print('Registration error: ${responseData['message']}');
        }
      } else {
        Get.dialog(
          AlertDialog(
            title: Text('Error'),
            content: Text('Failed to register'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
        print('Failed to register: ${response.statusCode}');
      }
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      print('Error: $e');
    }
  }
}
