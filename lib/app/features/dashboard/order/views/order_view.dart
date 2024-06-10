library order;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:marketplace/app/shared_components/item_order.dart';
import 'package:marketplace/app/utils/services/rest_api_services.dart';

part '../controllers/order_controller.dart';
part '../bindings/order_binding.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Order',
            style: TextStyle(fontSize: 12.sp),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(25.sp),
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    Get.toNamed('/resi');
                  },
                  child: _ProductContent(controller.getListOrder()))
            ],
          ),
        ));
  }
}

class _ProductContent extends StatelessWidget {
  const _ProductContent(this.data, {Key? key}) : super(key: key);

  final List<Product> data;
  // final Function(Product product) onPressed;

  @override
  Widget build(BuildContext context) {
    // print(data);
    // return Text("TES");
    return Wrap(
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.spaceBetween,
        children: List.generate(data.length, (int index) {
          // print(data[index]);
          return ItemOrder(
            heroTag: data[index].id_produk,
            data: ItemOrderData(
              id: index,
              image: data[index].gambar_produk[0],
              initialFavorite: true,
              brand: data[index].merk_produk,
              name: data[index].nama_produk,
              price: data[index].harga,
            ),
            onTap: () {
              // onPressed(data[index]);
            },
          );
        }));
  }
}
