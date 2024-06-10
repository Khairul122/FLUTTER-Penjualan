class CartItem {
  final int id;
  final String name;
  final double price;
  int quantity;
  final String imageUrl;
  bool isSelected;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.isSelected = false,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: int.parse(json['id_keranjang']), // Konversi ke int
      name: json['nama_produk'],
      price: double.parse(json['harga_produk']), // Konversi ke double
      quantity: json['quantity'] ?? 1, // Mengambil nilai quantity dari JSON atau default 1
      imageUrl: 'http://10.0.2.2/backend-penjualan/' + json['gambar_produk'], // Tambahkan base URL
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_keranjang': id.toString(), // Konversi ke String
      'nama_produk': name,
      'harga_produk': price.toString(), // Konversi ke String
      'quantity': quantity,
      'gambar_produk': imageUrl.replaceFirst('http://10.0.2.2/backend-penjualan/', ''), // Hapus base URL
    };
  }
}
