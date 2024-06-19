import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';

// Definisikan konstanta yang diperlukan
const double kBorderRadius = 12.0;
const double kSpacing = 8.0;
const List<Color> kFontColorPallets = [Colors.black];

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
      body: Padding(
        padding: EdgeInsets.all(25.sp),
        child: Obx(() {
          if (controller.orders.isEmpty) {
            return Center(child: Text("No orders found"));
          } else {
            print('Orders length: ${controller.orders.length}');
            return _ProductContent(controller.orders);
          }
        }),
      ),
    );
  }
}

class _ProductContent extends StatelessWidget {
  const _ProductContent(this.data, {Key? key}) : super(key: key);

  final List<Order> data;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runAlignment: WrapAlignment.spaceBetween,
      children: List.generate(data.length, (int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0), // Tambahkan jarak bawah 10px
          child: ItemOrder(
            heroTag: data[index].id_produk.toString(), // Ensure heroTag is a String
            data: ItemOrderData(
              id: index,
              image: NetworkImage(data[index].gambar_produk), // Ensure image is an ImageProvider
              initialFavorite: true,
              brand: data[index].merk_produk,
              name: data[index].nama_produk,
              price: data[index].total, // Use total as price
              quantity: data[index].quantity, 
              status_pembelian: data[index].status_pembelian, 
            ),
            onTap: () {
              print('Tapped on: ${data[index].nama_produk}');
              // Action on item tap can be added here
            },
          ),
        );
      }),
    );
  }
}

class ItemOrderData {
  final ImageProvider image;
  final double price;
  final int id;
  final String brand;
  final String name;
  final bool initialFavorite;
  final int quantity; 
  final String status_pembelian;

  const ItemOrderData({
    required this.image,
    required this.id,
    required this.price,
    required this.brand,
    required this.name,
    required this.initialFavorite,
    required this.quantity, 
    required this.status_pembelian,
  });
}

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    required this.data,
    required this.heroTag,
    this.onTap,
    this.onFavoriteChanged,
    Key? key,
  }) : super(key: key);

  final String heroTag;
  final ItemOrderData data;
  final Function()? onTap;
  final Function(bool isFavorite)? onFavoriteChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 5.sp,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Hero(
                tag: heroTag,
                child: GestureDetector(
                  onTap: onTap,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        _buildImage(data.image),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: kSpacing),
              _Indicator(),
            ],
          ),
          Container(
            padding: EdgeInsets.all(7.sp),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.sp)),
            child: Text(
              data.status_pembelian,
              style: TextStyle(fontSize: 10.sp),
            ),
          )
        ],
      ),
    );
  }

  Widget _Indicator() {
    return Wrap(
      direction: Axis.vertical,
      spacing: 5.sp,
      children: [
        _buildBrandProduct(data.brand),
        _buildNameProduct(data.name),
        _buildPriceText(data.price),
        _buildQuantityText(data.quantity), // Tambahkan teks jumlah
      ],
    );
  }

  Widget _buildImage(ImageProvider image) {
    return Container(
      height: 60.sp,
      width: 60.sp,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10.0, // Specifies the blur radius of the shadow
              spreadRadius: 0.0, // Specifies the spread radius of the shadow
            ),
          ],
          image: DecorationImage(
            image: image,
          )),
    );
  }

  Widget _buildPriceText(double price) {
    return Text(
      "Rp ${price}00,-",
      style: TextStyle(
        color: kFontColorPallets[0],
        fontSize: 10.sp,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildQuantityText(int quantity) {
    return Text(
      "Jumlah: $quantity",
      style: TextStyle(
        color: kFontColorPallets[0],
        fontSize: 10.sp,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildNameProduct(String name) {
    return Text(
      name,
      style: TextStyle(color: kFontColorPallets[0], fontSize: 12.sp),
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildBrandProduct(String name) {
    return Text(
      name,
      style: TextStyle(
          color: kFontColorPallets[0],
          fontSize: 12.sp,
          fontWeight: FontWeight.bold),
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
