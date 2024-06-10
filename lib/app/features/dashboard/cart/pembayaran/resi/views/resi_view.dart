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
          // title: const Text('ResiView'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(25.sp),
          child: Wrap(
              runSpacing: 10.sp,
              children: [_NomorResi(), Divider(), _DetailPesanan()]),
        ));
  }
}

Widget _NomorResi() {
  return Wrap(
    direction: Axis.vertical,
    spacing: 5.sp,
    // crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Nomor Resi",
        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
      ),
      Text(
        "002709009864",
        style: TextStyle(
          fontSize: 12.sp,
        ),
      )
    ],
  );
}

Widget _DetailPesanan() {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TextDetailPesanan("Nama Penerima", "John Doe"),
          SizedBox(
            height: 15.sp,
          ),
          _TextDetailPesanan(
            "Alamat Penerima",
            "Blang Pulo, Muara Satu, Kota \nLhokseumawe, NAD, 22154",
          )
        ],
      ),
      SizedBox(height: 15.sp,),
      Row(
        children: [
          _TextDetailPesanan("Estimasi Pengiriman", "21-25 Juni 2024"),
          SizedBox(
            height: 15.sp,
          ),
          _StatusDetailPesanan("Status", "Dikirim")
        ],
      ),
    ],
  );
}

Widget _TextDetailPesanan(label, subLabel) {
  return Container(
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
  );
}
Widget _StatusDetailPesanan(label, subLabel) {
  return Container(
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
            color: Colors.amber
          ),
        )
      ],
    ),
  );
}
