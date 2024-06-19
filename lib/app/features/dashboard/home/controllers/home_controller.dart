part of home;

class HomeController extends GetxController {
  final apiService = RestApiServices();

  // Variable to store selected category
  RxString selectedCategory = 'All'.obs;

  getAllProduct() => apiService.fetchData(
      baseUrl: "http://10.0.2.2/backend-penjualan/ProdukAPI.php");
  
  getAllExplore() => apiService.fetchData(
      baseUrl: "http://10.0.2.2/backend-penjualan/ProdukAPI.php");

  Future<List<dynamic>> getAllCategories() async {
    final response = await apiService.fetchData(
        baseUrl: "http://10.0.2.2/backend-penjualan/KategoriAPI.php");
    return response;
  }

  Future<List<dynamic>> getProductsByCategory(String category) async {
    String url = category == 'All'
        ? "http://10.0.2.2/backend-penjualan/KategoriProdukAPI.php"
        : "http://10.0.2.2/backend-penjualan/KategoriProdukAPI.php?category=$category";
    final response = await apiService.fetchData(baseUrl: url);
    return response;
  }

  void goToDetailProduct(Map<String, dynamic> product) {
    Get.toNamed(Routes.product + "/${product['id_produk']}", arguments: product);
  }

  void OpenDialogAds() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.dialog(
        AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Stack(
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text('X'),
              ),
              SizedBox(
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
    super.onInit();
    OpenDialogAds();
  }
}
