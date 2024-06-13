import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/resi_controller.dart';

class ResiView extends GetView<ResiController> {
  const ResiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      width: 0.42.sw,
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
          )
        ],
      ),
    ),
  );
}

Widget _StatusDetailPesanan(String label, String subLabel) {
  return Expanded(
    child: Container(
      width: 0.42.sw,
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
          )
        ],
      ),
    ),
  );
}
