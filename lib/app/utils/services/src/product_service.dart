part of rest_api_service;

/// FAKE PRODUCT SERVICE
// put all custom setup in RestApiService (duration timeout, exception handling , etc..)
// and extend restApiService, if you need custom service provider
class ProductService extends RestApiServices {
  static final ProductService _singleton = ProductService._internal();

  factory ProductService() {
    return _singleton;
  }
  ProductService._internal();

  Product? getProductByID(String id) {
    final allProduct = getAll();
    final result =
        allProduct.where((product) => product.id_produk == id).toList();
    return (result.length > 0) ? result[0] : null;
  }

  List<Product> getAll() {
    final response = fetchData(
        baseUrl: "http://10.0.2.2/backend-penjualan/ProdukAPI.php");
    // print("response: $response");
    return [];
  }

  List<Product> getExplore() {
    return [];
  }

  List<Product> getListCart() {
    return [];
  }

  List<Product> getListPembayaran() {
    return [];
  }

  List<Product> getListOrder() {
    return [];
  }
}
