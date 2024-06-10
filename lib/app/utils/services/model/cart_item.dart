class CartItem {
  final int id;
  final int productId;
  final String name;
  final double price;
  int quantity;
  final String imageUrl;
  bool isSelected;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.isSelected = false,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: int.parse(json['id_keranjang']),
      productId: int.parse(json['id_produk']),
      name: json['nama_produk'],
      price: double.parse(json['harga_produk']),
      quantity: 1, 
      imageUrl: 'http://10.0.2.2/backend-penjualan/' + json['gambar_produk'],
      isSelected: false,
    );
  }
}
