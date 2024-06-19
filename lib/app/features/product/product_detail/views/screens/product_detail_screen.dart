library product_detail;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:marketplace/app/constans/app_constants.dart';
import 'package:marketplace/app/shared_components/custom_button.dart';
import 'package:marketplace/app/shared_components/custom_icon_button.dart';
import 'package:marketplace/app/shared_components/indicator.dart';
import 'package:marketplace/app/utils/services/rest_api_services.dart';
import 'package:marketplace/app/utils/ui/ui_utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// binding
part '../../bindings/product_detail_binding.dart';

// controller
part '../../controllers/product_detail_controller.dart';

// component
part '../components/back_button.dart';
part '../components/favorite_button.dart';
part '../components/buy_button.dart';
part '../components/chat_button.dart';
part '../components/name_text.dart';
part '../components/body_content.dart';
part '../components/description_text.dart';
part '../components/price_text.dart';
part '../components/product_image.dart';
part '../components/rating.dart';
part '../components/review_text.dart';
part '../components/share_button.dart';
part '../components/views_text.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => (controller.data.value == null)
            ? Center(child: Text("Product Not Found"))
            : _buildProductDetail(
                product: controller.data.value!,
                // user: controller.dataUser.value!,
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(kSpacing / 2),
        child: SizedBox(
            width: 1.sw,
            child: CustomButton(
              label: "Add to Chart",
              onTap: () => _addToCart(controller.data.value!),
              textColor: Colors.white,
            )),
      ),
    );
  }

  Widget _buildProductDetail({required product}) {
    return Stack(
      children: [
        // DETAIL CONTENT
        SingleChildScrollView(
          controller: controller.scroll,
          child: Column(
            children: [
              Stack(
                children: [
                  // BACKGROUND IMAGES
                  Hero(
                      tag: product['id_produk'],
                      child: _ProductImage(product["gambar_produk"])),

                  // BODY
                  _BodyContent(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: kSpacing),
                        _NameText(product["nama_produk"]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: _PriceText(product['harga_produk'].toString()),
                            ),
                          ],
                        ),
                        SizedBox(height: kSpacing),
                        _DescriptionText(product['deskripsi_produk']),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        // HEADER BUTTON
        Obx(
          () => AnimatedOpacity(
            opacity: controller.opacityActionButton.value,
            duration: Duration(milliseconds: 200),
            onEnd: () => controller.onEndAnimationActionButton(),
            child: Visibility(
              visible: controller.isVisibleActionButton.value,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.sp,
                  vertical: 25.sp,
                ),
                child: Row(
                  children: [
                    _BackButton(onPressed: () => controller.back()),
                    Spacer(),
                    _ShareButton(onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<String> getUserId() async {
    var box = await Hive.openBox('userBox');
    var userData = box.get('user');
    return userData['id_pengguna'];
  }

  void _addToCart(Map<String, dynamic> product) async {
    final userId = await getUserId(); // Ambil ID pengguna dari Hive

    final url = Uri.parse('http://10.0.2.2/backend-penjualan/KeranjangAPI.php');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id_pengguna': userId, // Gunakan ID pengguna yang valid
        'id_produk': product['id_produk'],
        'status': 'pending', // Atau status lain yang sesuai
      }),
    );

    final responseData = jsonDecode(response.body);
    print('Response data: $responseData'); // Cetak respons lengkap dari server

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Berhasil Masuk Keranjang');
    } else {
      Get.snackbar('Error', 'Failed to add product to cart: ${responseData['message']}');
    }
  }
}
