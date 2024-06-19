import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marketplace/app/features/dashboard/cart/pembayaran/controllers/pembayaran_controller.dart';
import 'package:marketplace/app/shared_components/custom_button.dart';
import 'package:marketplace/app/shared_components/dashed_line.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:marketplace/app/shared_components/item_pembayaran.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';  // Tambahkan ini untuk menggunakan NumberFormat
import '../../../../../utils/services/model/products.dart';

class PembayaranView extends GetView<PembayaranController> {
  const PembayaranView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: 1.sh,
              width: 1.sw,
              padding: EdgeInsets.all(25.sp),
              child: Column(
                children: [
                  _alamatPengiriman(),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 2.0,
                    dashColor: Color(0xFFBA704F),
                    dashLength: 10.sp,
                    dashGapLength: 10.sp,
                  ),
                  Obx(() {
                    print("isLoading: ${controller.isLoading.value}");
                    print("Pembayaran List: ${controller.pembayaranList.map((p) => p.toJson()).toList()}"); // Logging detailed data
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.pembayaranList.isEmpty) {
                      return Center(child: Text('No items available'));
                    } else {
                      return _ProductContent(controller.pembayaranList);
                    }
                  }),
                  Divider(),
                  _opsiPengiriman(),
                  Divider(),
                  _metodePembayaran()
                ],
              ),
            ),
          ),
          Positioned(bottom: 0, child: _buatPesanan(controller)),
        ],
      ),
    );
  }
}

Widget _opsiPengiriman() {
  var box = Hive.box('userBox');
  var userData = box.get('user');
  String ongkir = userData['ongkir'];

  DateTime now = DateTime.now();
  DateTime startDate = now.add(Duration(days: 3));
  DateTime endDate = now.add(Duration(days: 4));
  String formattedStartDate = DateFormat('d MMMM').format(startDate);
  String formattedEndDate = DateFormat('d MMMM').format(endDate);

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
                    "Akan diterima pada tanggal $formattedStartDate - $formattedEndDate",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
                  ),
                  Text(
                    'Rp $ongkir',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
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
              'Transfer Bank',
              style: TextStyle(
                fontSize: 12.sp,
              ),
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

Widget _buatPesanan(PembayaranController controller) {
  final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

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
            Obx(() => Text(
              currencyFormatter.format(controller.calculateTotal()),
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            )),
          ],
        ),
        SizedBox(
            width: 0.4.sw,
            child: CustomButton(
              label: "Buat pesanan",
              onTap: () async {
                await controller.buatPesanan();
                // Tambahkan logika tambahan setelah pesanan dibuat, jika diperlukan
              },
              textColor: Colors.white,
            )),
      ],
    ),
  );
}

Widget _alamatPengiriman() {
  var box = Hive.box('userBox');
  var userData = box.get('user');

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
        "${userData['nama_pengguna']} | ${userData['no_telepon']} \n${userData['alamat']}",
        style: TextStyle(fontSize: 12.sp),
      ),
      SizedBox(
        height: 10.h,
      )
    ],
  );
}

class _ProductContent extends StatelessWidget {
  const _ProductContent(this.data, {Key? key}) : super(key: key);

  final List<Pembayaran> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(data.length, (int index) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(5.sp),
            child: Row(
              children: [
                Image.network(
                  data[index].gambar_produk,
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].nama_produk,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp ${data[index].harga_produk}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'x${data[index].quantity}',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
