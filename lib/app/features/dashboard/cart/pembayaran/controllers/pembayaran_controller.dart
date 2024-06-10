// lib/app/controllers/pembayaran_controller.dart
import 'package:get/get.dart';
import '../../../../../utils/services/model/products.dart';
import '../../../../../utils/services/pembayaran_service.dart';
import 'package:hive/hive.dart';

class PembayaranController extends GetxController {
  var pembayaranList = <Pembayaran>[].obs;
  var isLoading = true.obs;
  var userData = {}.obs;
  var alamat = ''.obs;
  var ongkir = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchPembayaran();
  }

  void fetchUserData() {
    var box = Hive.box('userBox');
    userData.value = {
      'id_pengguna': box.get('id_pengguna', defaultValue: 0),
      'nama_pengguna': 'Nama Pengguna',
      'no_telepon': '08123456789',
      'alamat': 'Alamat Lengkap'
    };
    alamat.value = 'Alamat Lengkap';
    ongkir.value = 10000; // Contoh ongkir
  }

  void fetchPembayaran() async {
    try {
      isLoading(true);
      int idPengguna = userData['id_pengguna'];
      print('Fetching pembayaran for id_pengguna: $idPengguna'); // Logging
      var payments = await PembayaranService().fetchPembayaran(idPengguna);
      pembayaranList.assignAll(payments);
      print('Data yang diambil dari REST API berdasarkan id_pengguna $idPengguna: $payments'); // Logging
    } catch (e) {
      print('Exception: $e'); // Logging exception
    } finally {
      isLoading(false);
    }
  }
}
