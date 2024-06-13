import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../../utils/services/model/products.dart';
import '../../payment/views/payment_view.dart';

class PembayaranController extends GetxController {
  var pembayaranList = <Pembayaran>[].obs;
  var isLoading = true.obs;
  static const String baseUrl = 'http://10.0.2.2/backend-penjualan/';

  @override
  void onInit() {
    super.onInit();
    fetchPembayaran();
  }

  void fetchPembayaran() async {
    var box = Hive.box('userBox');
    var userData = box.get('user');
    if (userData != null) {
      // Konversi id_pengguna ke integer
      int idPengguna = int.parse(userData['id_pengguna']);
      print('User data from Hive: $userData');

      var url = Uri.parse('${baseUrl}GetOrderAPI.php?id_pengguna=$idPengguna');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        try {
          var data = json.decode(response.body) as List;
          var pembayaran = data.map((item) {
            item['gambar_produk'] = baseUrl + item['gambar_produk']; // Menggabungkan host dengan path gambar
            return Pembayaran.fromJson(item);
          }).toList();
          pembayaranList.assignAll(pembayaran);
          
          // Logging data ke console
          print("Data yang diambil dari REST API berdasarkan id_pengguna $idPengguna:");
          for (var item in pembayaran) {
            print("ID Pembayaran: ${item.id_pembayaran}, Kode Transaksi: ${item.kode_transaksi}, Nama Produk: ${item.nama_produk}, Harga: ${item.harga_produk}, Gambar: ${item.gambar_produk}");
          }
        } catch (e) {
          print('Error parsing JSON: $e'); // Logging parsing error
          print('Raw response: ${response.body}'); // Logging raw response
        }
      } else {
        print("Gagal mengambil data dari REST API: ${response.body}");
      }
    } else {
      print("id_pengguna tidak ditemukan di Hive.");
    }
    isLoading(false);
  }

  double calculateTotal() {
    return pembayaranList.fold(0.0, (sum, item) => sum + item.total);
  }

  Future<void> buatPesanan() async {
    var box = Hive.box('userBox');
    var userData = box.get('user');
    if (userData != null) {
      int idPengguna = int.parse(userData['id_pengguna']);
      var url = Uri.parse('${baseUrl}UpdateOrderAPI.php');
      
      var response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id_pengguna': idPengguna}),
      );

      if (response.statusCode == 200) {
        print("Order updated successfully");
        // Tampilkan dialog sukses
        Get.dialog(
          AlertDialog(
            title: Text('Pesanan Berhasil Dibuat'),
            content: Text('Pesanan Anda telah berhasil dibuat.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Get.to(() => PaymentView());
                },
              ),
            ],
          ),
        );
      } else {
        print("Failed to update order: ${response.body}");
        // Handle failure (e.g., show an error message)
      }
    } else {
      print("id_pengguna tidak ditemukan di Hive.");
    }
  }
}
