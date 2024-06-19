import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:marketplace/app/features/dashboard/cart/pembayaran/resi/views/resi_view.dart';
import 'dart:math';

class PaymentController extends GetxController {
  var bankName = 'Bank BNI'.obs;
  var accountName = 'PT Fliptech Lentera Inspirasi Pertiwi'.obs;
  var accountNumber = '1000437442'.obs;
  var amount = 0.0.obs;
  var uniqueCode = 0.obs;
  var deadline = DateTime.now().add(Duration(hours: 6)).obs; // Example deadline
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTotalAmount();
  }

  String formatCurrency(double amount) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return currencyFormatter.format(amount);
  }

  String formatDeadline(DateTime deadline) {
    final deadlineFormatter = DateFormat('d MMM yyyy, HH:mm WIB');
    return deadlineFormatter.format(deadline);
  }

  void fetchTotalAmount() async {
    var box = Hive.box('userBox');
    var userData = box.get('user');
    if (userData != null) {
      int idPengguna = int.parse(userData['id_pengguna']);
      var url = Uri.parse(
          'http://10.0.2.2/backend-penjualan/GetOrderAPI.php?id_pengguna=$idPengguna');

      try {
        var response = await http.get(url);
        if (response.statusCode == 200) {
          var data = json.decode(response.body) as List;
          double totalAmount = data.fold(
              0.0, (sum, item) => sum + double.parse(item['total'].toString()));

          // Generate unique 3 digit code
          uniqueCode.value =
              Random().nextInt(900) + 100; // Random number between 100 and 999
          amount.value = totalAmount + uniqueCode.value;
        } else {
          print("Failed to load total amount: ${response.body}");
        }
      } catch (e) {
        print("Error fetching total amount: $e");
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> confirmTransfer() async {
    isLoading.value = true;
    var box = Hive.box('userBox');
    var userData = box.get('user');
    if (userData != null) {
      int idPengguna = int.parse(userData['id_pengguna']);
      var url =
          Uri.parse('http://10.0.2.2/backend-penjualan/updateKeranjangStatusAPI.php');

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id_pengguna': idPengguna}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          Get.snackbar('Success', 'Status updated successfully');
        } else {
          Get.snackbar('Error', 'Failed to update status: ${data['message']}');
        }
        Get.defaultDialog(
          title: "Sukses",
          middleText: "Data Berhasil Disimpan",
          textConfirm: "OK",
          onConfirm: () {
            Get.to(() => ResiView());
          },
        );
      } else {
        print("Failed to update status: ${response.body}");
        Get.snackbar('Error', 'Failed to update status',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      print("id_pengguna tidak ditemukan di Hive.");
      Get.snackbar('Error', 'id_pengguna tidak ditemukan di Hive.',
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.value = false;
  }
}
