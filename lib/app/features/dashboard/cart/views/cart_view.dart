import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Saya', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(child: Text('No items in cart', style: TextStyle(fontSize: 18)));
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchCartItems(); // Memanggil fungsi untuk mengambil data keranjang terbaru
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.cartItems[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: item.isSelected,
                                onChanged: (bool? value) {
                                  item.isSelected = value ?? false;
                                  controller.cartItems.refresh();
                                  controller.calculateTotal();
                                },
                              ),
                              Image.network(item.imageUrl, width: 80, height: 80, fit: BoxFit.cover),
                              SizedBox(width: 10),
                              Expanded( // Gunakan Expanded untuk menghindari overflow
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('\Rp${item.price}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (item.quantity > 1) {
                                              item.quantity--;
                                              controller.cartItems.refresh();
                                              controller.calculateTotal();
                                            }
                                          },
                                          icon: Icon(Icons.remove),
                                          color: Colors.red,
                                        ),
                                        Text('${item.quantity}', style: TextStyle(fontSize: 16)),
                                        IconButton(
                                          onPressed: () {
                                            item.quantity++;
                                            controller.cartItems.refresh();
                                            controller.calculateTotal();
                                          },
                                          icon: Icon(Icons.add),
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: controller.allItemsSelected,
                            onChanged: (bool? value) {
                              controller.selectAllItems(value ?? false);
                            },
                          ),
                          Text('Semua', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Obx(() => Text('Total \Rp${controller.totalAmount}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await controller.saveCartToDatabase(context);
                      controller.fetchCartItems(); // Memanggil fetchCartItems setelah checkout untuk mendapatkan data terbaru
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(157, 94, 0, 1),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Center(child: Text('Checkout (${controller.totalQuantity})')),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
