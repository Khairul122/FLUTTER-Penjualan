import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:marketplace/app/constans/app_constants.dart';
import 'package:marketplace/app/shared_components/custom_button.dart';
import 'package:marketplace/app/utils/ui/ui_utils.dart';

class ItemPembayaranData {
  final ImageProvider image;
  final double price;
  final int id;
  final String brand;
  final String name;
  final bool initialFavorite;

  const ItemPembayaranData({
    required this.image,
    required this.id,
    required this.price,
    required this.brand,
    required this.name,
    required this.initialFavorite,
  });
}

class ItemPembayaran extends StatelessWidget {
  const ItemPembayaran({
    required this.data,
    required this.heroTag,
    this.onTap,
    this.onFavoriteChanged,
    Key? key,
  }) : super(key: key);

  final String heroTag;
  final ItemPembayaranData data;
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
          Text(
            "x1",
            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
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
      ],
    );
  }

  Widget _buildImage(ImageProvider image) {
    return Container(
      // margin: EdgeInsets.all(2.0.sp),
      // padding: EdgeInsets.all(10.sp),
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
      // child: Image(
      //   image: image,
      //   fit: BoxFit.cover,
      // ),
    );
  }

  Widget _buildPriceText(double price) {
    return Text(
      "Rp ${price}00,-",
      style: TextStyle(
        color: kFontColorPallets[0],
        // fontWeight: FontWeight.bold,
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
