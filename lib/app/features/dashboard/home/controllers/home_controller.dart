part of home;

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final apiService = RestApiServices();

  getAllProduct() => apiService.fetchData(
      baseUrl: "http://10.0.2.2/backend-penjualan/ProdukAPI.php");
  getAllExplore() => apiService.fetchData(
      baseUrl: "http://10.0.2.2/backend-penjualan/ProdukAPI.php");
  // List<Product> getAllExplore() => productService.getExplore();

  void goToDetailProduct(Map<String, dynamic> product) {
    // print(product);
    Get.toNamed(Routes.product + "/${product['id_produk']}",
        arguments: product);
  }

  void OpenDialogAds() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.dialog(
        AlertDialog(
          backgroundColor:
              Colors.transparent, // Set background color to transparent
          contentPadding: EdgeInsets.zero, // Remove default padding
          content: Stack(
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text('X'),
              ),
              SizedBox(
                // height: 200,
                child: Image.asset(
                  "assets/images/adsBanner.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void onInit() {
    OpenDialogAds();
    super.onInit();
  }
}
