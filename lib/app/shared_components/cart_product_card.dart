import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:marketplace/app/constans/app_constants.dart';
import 'package:marketplace/app/shared_components/custom_button.dart';
import 'package:marketplace/app/utils/ui/ui_utils.dart';

class CartCardData {
  final ImageProvider image;
  final double price;
  final int id;
  final String brand;
  final String name;
  final bool initialFavorite;

  const CartCardData({
    required this.image,
    required this.id,
    required this.price,
    required this.brand,
    required this.name,
    required this.initialFavorite,
  });
}

class CartCard extends StatelessWidget {
  const CartCard({
    required this.data,
    required this.heroTag,
    this.onTap,
    this.onFavoriteChanged,
    Key? key,
  }) : super(key: key);

  final String heroTag;
  final CartCardData data;
  final Function()? onTap;
  final Function(bool isFavorite)? onFavoriteChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      // color: Colors.black,
      // height: 170.h,
      width: 1.sw,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: true,
              onChanged: (value) => print(value),
              fillColor: MaterialStateProperty.all(Color(0xFFBA704F)),
            ),
          ),
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
          _Indicator()
        ],
      ),
    );
  }

  Widget _Indicator() {
    return Expanded(
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 15.sp,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildBrandProduct(data.brand),
              _buildNameProduct(data.name),
              _buildPriceText(data.price),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                child: CustomButton(label: "-", onTap: () {}),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.sp, vertical: 8.sp),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.sp)),
                child: Text("0"),
              ),
              SizedBox(
                child: CustomButton(label: "+", onTap: () {}),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildImage(ImageProvider image) {
    return Container(
      margin: EdgeInsets.all(2.0.sp),
      // padding: EdgeInsets.all(10.sp),
      height: 180.sp,
      width: 120.sp,
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

  Widget _buildPriceText(price) {
    return Text(
      "Rp ${price}",
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
