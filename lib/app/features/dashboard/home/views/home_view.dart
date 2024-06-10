library home;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:marketplace/app/config/routes/app_pages.dart';
import 'package:marketplace/app/constans/app_constants.dart';
import 'package:marketplace/app/shared_components/product_card.dart';
import 'package:marketplace/app/utils/services/rest_api_services.dart';

part '../controllers/home_controller.dart';
part '../bindings/home_binding.dart';
part '../../home/components/product_content.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: 1.sh,
        width: 1.sw,
        padding: EdgeInsets.only(
          top: 25.sp,
          bottom: 25.sp,
        ),
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 10.sp,
            children: [_topPopuler(controller), _explore(controller)],
          ),
        ),
      ),
    ));
  }
}

Widget _topPopuler(controller) {
  return Wrap(
    children: [
      Padding(
        padding: EdgeInsets.only(left: 25.0.sp),
        child: Text(
          "Top \nPopuler",
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 25.0.sp),
          child: _ProductContent(controller.getAllProduct(),
              onPressed: ((product) {
            // print(product);
            controller.goToDetailProduct(product);
          })),
        ),
      ),
    ],
  );
}

Widget _explore(controller) {
  return Wrap(
    children: [
      Padding(
        padding: EdgeInsets.only(left: 25.0.sp),
        child: Text(
          "Explore",
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 25.0.sp),
        child: _ProductContent(controller.getAllExplore(),
            onPressed: ((product) => controller.goToDetailProduct(product))),
      ),
    ],
  );
}
