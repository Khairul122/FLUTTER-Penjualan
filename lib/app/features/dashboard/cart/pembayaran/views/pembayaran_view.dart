// lib/app/views/pembayaran_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marketplace/app/shared_components/custom_button.dart';
import 'package:marketplace/app/shared_components/dashed_line.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:marketplace/app/shared_components/item_pembayaran.dart';
import 'package:marketplace/app/utils/services/model/products.dart';
import 'package:marketplace/app/utils/services/rest_api_services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../controllers/pembayaran_controller.dart';

class PembayaranView extends StatelessWidget {
  const PembayaranView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PembayaranController controller = Get.put(PembayaranController());

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: 1.sh,
              width: 1.sw,
              padding: EdgeInsets.all(25.sp),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.pembayaranList.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  return Wrap(
                    runSpacing: 15.sp,
                    children: [
                      _alamatPengiriman(controller),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 2.0,
                        dashColor: Color(0xFFBA704F),
                        dashLength: 10.sp,
                        dashGapLength: 10.sp,
                      ),
                      _ProductContent(controller.pembayaranList),
                      Divider(),
                      _opsiPengiriman(controller),
                      Divider(),
                      _metodePembayaran()
                    ],
                  );
                }
              }),
            ),
          ),
          Positioned(bottom: 0, child: _buatPesanan()),
        ],
      ),
    );
  }
}

Widget _opsiPengiriman(PembayaranController controller) {
  return Obx(() {
    var now = DateTime.now();
    var deliveryDate = DateFormat('dd MMMM').format(now.add(Duration(days: 3)));
    var ongkir = controller.ongkir.value;

    return Container(
      width: 1.sw,
      child: Wrap(
        direction: Axis.vertical,
        spacing: 5.sp,
        children: [
          Text(
            "Opsi Pengiriman",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reguler",
                style: TextStyle(fontSize: 12.sp),
              ),
              Container(
                width: 0.86.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Akan diterima pada tanggal $deliveryDate",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
                    ),
                    Obx(() => Text(
                          "Rp. ${controller.ongkir.value}",
                          style: TextStyle(fontSize: 12.sp),
                        )),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  });
}

Widget _metodePembayaran() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Metode Pembayaran",
        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
      ),
      Column(
        children: [
          RadioListTile<String>(
            title: Text(
              'COD',
              style: TextStyle(fontSize: 12.sp),
            ),
            value: 'COD',
            groupValue: "COD",
            onChanged: (value) {},
          ),
        ],
      ),
    ],
  );
}

Widget _buatPesanan() {
  return Container(
    padding: EdgeInsets.all(25.sp),
    width: 1.sw,
    height: 100.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Pembayaran",
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              "Rp0.,-",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
            width: 0.4.sw,
            child: CustomButton(
              label: "Buat pesanan",
              onTap: () {
                Get.toNamed("/pembayaran");
              },
              textColor: Colors.white,
            )),
      ],
    ),
  );
}

Widget _alamatPengiriman(PembayaranController controller) {
  return Obx(() {
    var userData = controller.userData.value;
    var alamat = controller.alamat.value;

    if (userData.isNotEmpty && alamat.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_sharp),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "Alamat Pengiriman",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "${userData['nama_pengguna']} | (+62) ${userData['no_telepon']} \n${alamat}",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_sharp),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "Alamat Pengiriman",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Data alamat tidak tersedia.",
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      );
    }
  });
}

class _ProductContent extends StatelessWidget {
  const _ProductContent(this.data, {Key? key}) : super(key: key);

  final List<Pembayaran> data;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runAlignment: WrapAlignment.spaceBetween,
      children: List.generate(data.length, (int index) {
        return ItemPembayaran(
          heroTag: data[index].id_produk.toString(),
          data: ItemPembayaranData(
            id: data[index].id_pembayaran.toInt(),
            image: NetworkImage(data[index].gambar_produk), // Perbaiki tipe data gambar
            initialFavorite: true,
            brand: "", // Isi brand jika ada
            name: data[index].kode_transaksi,
            price: data[index].total.toDouble(), // Konversi double ke string
          ),
          onTap: () {},
        );
      }),
    );
  }
}
