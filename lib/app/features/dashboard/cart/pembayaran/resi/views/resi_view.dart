import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/resi_controller.dart';

class ResiView extends StatelessWidget {
  const ResiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Inisialisasi ResiController menggunakan Get.put
    final ResiController controller = Get.put(ResiController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.sp),
        child: Obx(() => Wrap(
          runSpacing: 10.sp,
          children: [
            _NomorResi(controller.kodeTransaksi.value),
            Divider(),
            _DetailPesanan(
              controller.namaPengguna.value,
              controller.alamat.value,
              controller.estimasiPengiriman.value,
              controller.statusPembelian.value,
            ),
            SizedBox(height: 20.sp),
            _BackToDashboardButton(),
          ],
        )),
      ),
    );
  }
}

Widget _NomorResi(String kodeTransaksi) {
  return Wrap(
    direction: Axis.vertical,
    spacing: 5.sp,
    children: [
      Text(
        "Kode Transaksi",
        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
      ),
      Text(
        kodeTransaksi,
        style: TextStyle(
          fontSize: 12.sp,
        ),
      ),
    ],
  );
}

Widget _DetailPesanan(String namaPengguna, String alamat, String estimasiPengiriman, String statusPembelian) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TextDetailPesanan("Nama Penerima", namaPengguna),
          SizedBox(
            width: 15.sp,
          ),
          _TextDetailPesanan(
            "Alamat Penerima",
            alamat,
          ),
        ],
      ),
      SizedBox(height: 15.sp,),
      Row(
        children: [
          _TextDetailPesanan("Estimasi Pengiriman", estimasiPengiriman),
          SizedBox(
            width: 15.sp,
          ),
          _StatusDetailPesanan("Status", statusPembelian)
        ],
      ),
    ],
  );
}

Widget _TextDetailPesanan(String label, String subLabel) {
  return Expanded(
    child: Container(
      child: Wrap(
        direction: Axis.vertical,
        spacing: 5.sp,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            subLabel,
            style: TextStyle(
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _StatusDetailPesanan(String label, String subLabel) {
  return Expanded(
    child: Container(
      child: Wrap(
        direction: Axis.vertical,
        spacing: 5.sp,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            subLabel,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _BackToDashboardButton() {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        Get.toNamed('/dashboard');
      },
      child: Text('Kembali ke Dashboard'),
    ),
  );
}
