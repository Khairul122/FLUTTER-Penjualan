import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../app/utils/services/model/cart_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs; // Observable list untuk menyimpan item cart
  var totalAmount = 0.0.obs; // Observable untuk total harga
  var box = Hive.box('userBox'); // Box Hive untuk menyimpan data pengguna

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  void fetchCartItems() async {
    var userData = box.get('user');
    if (userData != null) {
      // Konversi id_pengguna ke integer
      int idPengguna = int.parse(userData['id_pengguna']);
      print('User data from Hive: $userData');

      var url = Uri.parse('http://10.0.2.2/backend-penjualan/KeranjangAPI.php?id_pengguna=$idPengguna');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        var items = data.map((item) => CartItem.fromJson(item)).toList();
        cartItems.assignAll(items);
        calculateTotal();
        
        // Logging data ke console
        print("Data yang diambil dari REST API berdasarkan id_pengguna $idPengguna:");
        for (var item in items) {
          print("ID Keranjang: ${item.id}, ID Produk: ${item.productId}, Nama: ${item.name}, Harga: ${item.price}, Gambar: ${item.imageUrl}");
        }
      } else {
        print("Gagal mengambil data dari REST API: ${response.body}");
      }
    } else {
      print("id_pengguna tidak ditemukan di Hive.");
    }
  }

  void calculateTotal() {
    totalAmount.value = cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  bool get allItemsSelected => cartItems.every((item) => item.isSelected);
  int get totalQuantity => cartItems.fold(0, (sum, item) => sum + item.quantity);

  void selectAllItems(bool value) {
    for (var item in cartItems) {
      item.isSelected = value;
    }
    cartItems.refresh();
    calculateTotal();
  }

  String generateTransactionCode(int count) {
    final prefix = 'AKM';
    final number = count.toString().padLeft(3, '0');
    return '$prefix$number';
  }

  Future<int> fetchTransactionCount() async {
    var url = Uri.parse('http://10.0.2.2/backend-penjualan/TransactionCountAPI.php');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['count'];
    } else {
      throw Exception("Failed to fetch transaction count");
    }
  }

  Future<void> saveCartToDatabase(BuildContext context) async {
    var userData = box.get('user');
    if (userData != null) {
      int idPengguna = int.parse(userData['id_pengguna']);

      var selectedItems = cartItems.where((item) => item.isSelected).toList();
      if (selectedItems.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Tidak Ada Data yang Dipilih'),
              content: Text('Silakan pilih item yang ingin di-checkout.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }

      try {
        final transactionCount = await fetchTransactionCount();
        final transactionCode = generateTransactionCode(transactionCount + 1);

        var cartData = selectedItems.map((item) => {
          'id_keranjang': item.id, // Tambahkan id_keranjang
          'id_produk': item.productId,
          'harga_produk': item.price,
          'quantity': item.quantity,
          'kode_transaksi': transactionCode,
        }).toList();

        var body = jsonEncode({
          'id_pengguna': idPengguna,
          'cart_items': cartData
        });

        // Print the data to the console before sending
        print("Data yang dikirim ke backend:");
        print(body);

        var url = Uri.parse('http://10.0.2.2/backend-penjualan/saveCartToDatabaseAPI.php');
        var response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);

        print("Response dari backend:");
        print(response.body);

        if (response.statusCode == 200) {
          var responseData = json.decode(response.body);
          if (responseData['status'] == 'success') {
            // Berhasil menyimpan data
            Get.snackbar('Success', 'Cart items have been saved to database.');
            fetchCartItems(); // Refresh data setelah berhasil menyimpan
            Get.toNamed('/pembayaran'); // Navigasi ke halaman pembayaran
          } else {
            // Gagal menyimpan data
            print("Errors: ${responseData['errors']}");
            Get.snackbar('Error', 'Failed to save cart items to database.');
          }
        } else {
          // Gagal menyimpan data
          Get.snackbar('Error', 'Failed to save cart items to database. Server error.');
        }
      } catch (e) {
        print("Error: $e");
        Get.snackbar('Error', 'Failed to generate transaction code.');
      }
    } else {
      print("id_pengguna tidak ditemukan di Hive.");
    }
  }
}
