import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ResiController extends GetxController {
  var kodeTransaksi = ''.obs;
  var namaPengguna = ''.obs;
  var alamat = ''.obs;
  var estimasiPengiriman = ''.obs;
  var statusPembelian = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderDetails();
  }

  void fetchOrderDetails() async {
    var box = Hive.box('userBox');
    var userData = box.get('user');
    if (userData != null) {
      int idPengguna = int.parse(userData['id_pengguna']);
      var url = Uri.parse('http://10.0.2.2/backend-penjualan/GetLatestOrderDetailsAPI.php?id_pengguna=$idPengguna');
      
      try {
        var response = await http.get(url);
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          if (data.isNotEmpty) {
            kodeTransaksi.value = data['kode_transaksi'];
            namaPengguna.value = data['nama_pengguna'];
            alamat.value = data['alamat'];
            statusPembelian.value = data['status_pembelian'];

            // Calculate estimated delivery date
            DateTime now = DateTime.now();
            DateTime startDate = now.add(Duration(days: 3));
            DateTime endDate = now.add(Duration(days: 4));
            String formattedStartDate = DateFormat('d MMMM yyyy', 'id_ID').format(startDate);
            String formattedEndDate = DateFormat('d MMMM yyyy', 'id_ID').format(endDate);
            estimasiPengiriman.value = '$formattedStartDate - $formattedEndDate';
          }
        } else {
          print("Failed to load order details: ${response.body}");
        }
      } catch (e) {
        print("Error fetching order details: $e");
      }
    } else {
      print("id_pengguna tidak ditemukan di Hive.");
    }
  }
}
