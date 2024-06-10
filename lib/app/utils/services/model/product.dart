part of rest_api_service;

class Product {
  final List<ImageProvider> gambar_produk;
  final String id_produk;
  final String merk_produk;
  final String nama_produk;
  final double harga;

  const Product({
    required this.gambar_produk,
    required this.id_produk,
    required this.merk_produk,
    required this.nama_produk,
    required this.harga,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        gambar_produk: json[''],
        id_produk: json['id_produk'],
        nama_produk: json['nama_produk'],
        harga: json['harga'].toDouble(),
        merk_produk: json['merk_produk']);
  }
}
