import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:marketplace/app/constans/app_constants.dart';
import 'package:marketplace/app/utils/ui/ui_utils.dart';
import 'package:intl/intl.dart';

class ProductCardData {
  final String image;
  final double price;
  final int id;
  final String brand;
  final String name;
  final bool initialFavorite;

  const ProductCardData({
    required this.image,
    required this.id,
    required this.price,
    required this.brand,
    required this.name,
    required this.initialFavorite,
  });
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.data,
    required this.heroTag,
    this.onTap,
    this.onFavoriteChanged,
    Key? key,
  }) : super(key: key);

  final String heroTag;
  final ProductCardData data;
  final Function()? onTap;
  final Function(bool isFavorite)? onFavoriteChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      width: 150.w,
      child: Column(
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
                    // _buildFavoriteIcon(
                    //   data.initialFavorite,
                    //   onTap: (isFavorite) {
                    //     if (onFavoriteChanged != null) {
                    //       onFavoriteChanged!(isFavorite);
                    //     }
                    //     AppSnackbar.showStatusFavoriteProduct(
                    //       isFavorite: isFavorite,
                    //       productImage: data.image,
                    //       productName: data.name,
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: kSpacing),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildBrandProduct(data.brand),
              _buildNameProduct(data.name),
              _buildPriceText(data.price),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildImage(image) {
    return Container(
      margin: EdgeInsets.all(2.0.sp),
      // padding: EdgeInsets.all(10.sp),
      height: 160.sp,
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
              image: NetworkImage(
                  "http://10.0.2.2/backend-penjualan/$image"),
              fit: BoxFit.cover)),
      // child: Image(
      //   image: image,
      //   fit: BoxFit.cover,
      // ),
    );
  }

  Widget _buildFavoriteIcon(
    bool initialFavorite, {
    required Function(bool isFavorite) onTap,
  }) {
    RxBool isFavorite = RxBool(initialFavorite);

    Color activeColor = Theme.of(Get.context!).primaryColor;
    Color? passiveColor = Theme.of(Get.context!).iconTheme.color;

    return Obx(
      () => Material(
        color: isFavorite.value ? activeColor : passiveColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kBorderRadius),
        ),
        child: Container(
          height: 40.h,
          width: 40.w,
          child: InkWell(
            onTap: () {
              isFavorite.toggle();
              onTap(isFavorite.value);
            },
            child: Icon(
              FontAwesomeIcons.solidStar,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

Widget _buildPriceText(double price) {
  final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
  String formattedPrice = formatCurrency.format(price);
  return Text(
    formattedPrice,
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
