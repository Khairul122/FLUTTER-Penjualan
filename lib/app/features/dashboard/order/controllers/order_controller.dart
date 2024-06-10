part of order;

class OrderController extends GetxController {
  //TODO: Implement OrderController
  final productService = ProductService();

  List<Product> getListOrder() => productService.getListOrder();
  

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  
}
