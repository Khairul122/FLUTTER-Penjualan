library home;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:marketplace/app/config/routes/app_pages.dart';
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
            child: Column(
              children: [
                _imageSlider(),
                SizedBox(height: 20.sp),
                _categoryList(controller),
                SizedBox(height: 20.sp),
                Obx(() => _explore(controller)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _imageSlider() {
  final List<String> imageList = [
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpg',
  ];

  return CarouselSlider(
    options: CarouselOptions(
      height: 200.sp,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      enlargeCenterPage: true,
    ),
    items: imageList.map((imagePath) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: 1.sw,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          );
        },
      );
    }).toList(),
  );
}

Widget _categoryList(HomeController controller) {
  return FutureBuilder(
    future: controller.getAllCategories(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
        return Text('No categories found');
      } else {
        List categories = snapshot.data as List;
        categories.insert(0, {'nama_kategori': 'All'}); // Tambahkan "All" di awal daftar
        return Container(
          height: 50.sp,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              String category = categories[index]['nama_kategori'];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: Obx(() => ChoiceChip(
                  label: Text(category),
                  selected: controller.selectedCategory.value == category,
                  onSelected: (selected) {
                    controller.selectedCategory.value = category;
                  },
                )),
              );
            },
          ),
        );
      }
    },
  );
}

Widget _explore(HomeController controller) {
  return FutureBuilder(
    future: controller.getProductsByCategory(controller.selectedCategory.value),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
        return Text('No products found');
      } else {
        List products = snapshot.data as List;
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            final productCardData = ProductCardData(
              image: product['gambar_produk'],
              id: int.parse(product['id_produk']), // Konversi ke int
              price: double.parse(product['harga_produk']), // Konversi ke double
              brand: product['merk_produk'],
              name: product['nama_produk'],
              initialFavorite: false, // Sesuaikan jika ada data favorit
            );
            return ProductCard(
              data: productCardData,
              heroTag: 'product-${product['id_produk']}',
              onTap: () => controller.goToDetailProduct(product),
            );
          },
        );
      }
    },
  );
}
