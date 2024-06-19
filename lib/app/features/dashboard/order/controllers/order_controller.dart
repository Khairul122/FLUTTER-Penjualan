import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'dart:async';

class OrderController extends GetxController {
  var orders = <Order>[].obs;
  late Box userBox; // Kotak untuk menyimpan data pengguna dari Hive
  Timer? timer; // Timer untuk refresh data

  @override
  void onInit() {
    super.onInit();
    userBox = Hive.box('userBox'); // Buka kotak Hive
    print('User data from Hive: ${userBox.toMap()}');
    fetchOrdersFromApi();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => fetchOrdersFromApi()); // Refresh data setiap 2 detik
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void fetchOrdersFromApi() async {
    var userData = userBox.get('user');
    if (userData != null) {
      // Konversi id_pengguna ke integer
      int idPengguna = int.parse(userData['id_pengguna'].toString());
      print('User data from Hive: $userData');

      var url = Uri.parse('http://10.0.2.2/backend-penjualan/GetPaidOrdersAPI.php?id_pengguna=$idPengguna');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          var ordersData = data['orders'] as List;
          if (ordersData.isEmpty) {
            print('Orders data is empty.');
          } else {
            var items = ordersData.map((item) => Order.fromJson(item)).toList();
            orders.assignAll(items);
            print("Data yang diambil dari REST API berdasarkan id_pengguna $idPengguna:");
            for (var item in items) {
              print("ID Produk: ${item.id_produk}, Nama: ${item.nama_produk}, Harga: ${item.total}, Gambar: ${item.gambar_produk}, Jumlah: ${item.quantity}");
            }
          }
        } else {
          print("Gagal mengambil data dari REST API: ${data['message']}");
        }
      } else {
        print("Gagal mengambil data dari REST API: ${response.body}");
      }
    } else {
      print("id_pengguna tidak ditemukan di Hive.");
    }
  }

  void showErrorDialog(String message) {
    Get.defaultDialog(
      title: 'Error',
      middleText: message,
      textConfirm: 'OK',
      onConfirm: () {
        Get.back();
      },
    );
  }
}

class Order {
  final int id_produk;
  final String nama_produk;
  final String merk_produk;
  final String gambar_produk;
  final double total;
  final String deskripsi_produk;
  final int stok_produk;
  final int id_kategori;
  final int id_pengguna;
  final String nama_pengguna;
  final String email;
  final String no_telepon;
  final String alamat;
  final int ongkir;
  final int quantity;
   final String status_pembelian;

  Order({
    required this.id_produk,
    required this.nama_produk,
    required this.merk_produk,
    required this.gambar_produk,
    required this.total,
    required this.deskripsi_produk,
    required this.stok_produk,
    required this.id_kategori,
    required this.id_pengguna,
    required this.nama_pengguna,
    required this.email,
    required this.no_telepon,
    required this.alamat,
    required this.ongkir,
    required this.quantity,
    required this.status_pembelian,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id_produk: json['id_produk'],
      nama_produk: json['nama_produk'] ?? '',
      merk_produk: json['merk_produk'] ?? '',
      gambar_produk: 'http://10.0.2.2/backend-penjualan/' + (json['gambar_produk'] ?? ''),
      total: json['total'].toDouble() ?? 0.0,
      deskripsi_produk: json['deskripsi_produk'] ?? '',
      stok_produk: json['stok_produk'] ?? 0,
      id_kategori: json['id_kategori'] ?? 0,
      id_pengguna: json['id_pengguna'] ?? 0,
      nama_pengguna: json['nama_pengguna'] ?? '',
      email: json['email'] ?? '',
      no_telepon: json['no_telepon'] ?? '',
      alamat: json['alamat'] ?? '',
      ongkir: json['ongkir'] ?? 0,
      quantity: json['quantity'] ?? 0,
      status_pembelian: json['status_pembelian'] ?? '',
      
    );
  }
}
