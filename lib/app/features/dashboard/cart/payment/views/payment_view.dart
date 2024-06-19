import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,  // Remove shadow
        title: Text('Transfer Sekarang', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mohon transfer ke Rizka',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 4),
              Obx(() => Text(
                'untuk diteruskan ke ${controller.accountName}',
                style: TextStyle(fontSize: 18),
              )),
              SizedBox(height: 16),
              Obx(() => Text(
                'Transfer sebelum ${controller.formatDeadline(controller.deadline.value)}',
                style: TextStyle(fontSize: 16, color: Colors.red),
              )),
              SizedBox(height: 16),
              Divider(thickness: 1.5),
        
              SizedBox(height: 8),
              ListTile(
                title: Obx(() => Text(
                  controller.accountNumber.value,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
                trailing: TextButton.icon(
                  onPressed: () {
                    // Logic to copy account number to clipboard
                  },
                  icon: Icon(Icons.copy, color: Colors.orange),
                  label: Text('Salin', style: TextStyle(color: Colors.orange)),
                ),
              ),
              SizedBox(height: 8),
              ListTile(
                title: Text(
                  'Jumlah Transfer',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.formatCurrency(controller.amount.value),
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        Text(
                          'Termasuk kode unik: ${controller.uniqueCode.value}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    );
                  }
                }),
                trailing: TextButton.icon(
                  onPressed: () {
                    // Logic to copy amount to clipboard
                  },
                  icon: Icon(Icons.copy, color: Colors.orange),
                  label: Text('Salin', style: TextStyle(color: Colors.orange)),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Jika sudah transfer, mohon klik tombol di bawah ini agar kami bisa lanjutkan pesanan Anda.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Divider(thickness: 1.5),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.confirmTransfer();
                  },
                  child: Text('Saya Sudah Transfer', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    primary: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
