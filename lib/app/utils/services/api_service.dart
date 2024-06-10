import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2/backend-penjualan/GetOrderAPI.php';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['records'] as List).map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat produk');
    }
  }
}

class Product {
  final String idPembayaran;
  final String kodeTransaksi;
  final String idPengguna;
  final String namaPengguna;
  final String email;
  final String noTelepon;
  final String idAlamat;
  final String idProduk;
  final String namaProduk;
  final String merkProduk;
  final String gambarProduk;
  final String hargaProduk;
  final String deskripsiProduk;
  final String stokProduk;
  final String quantity;
  final String total;
  final String createdAt;

  Product({
    required this.idPembayaran,
    required this.kodeTransaksi,
    required this.idPengguna,
    required this.namaPengguna,
    required this.email,
    required this.noTelepon,
    required this.idAlamat,
    required this.idProduk,
    required this.namaProduk,
    required this.merkProduk,
    required this.gambarProduk,
    required this.hargaProduk,
    required this.deskripsiProduk,
    required this.stokProduk,
    required this.quantity,
    required this.total,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      idPembayaran: json['id_pembayaran'],
      kodeTransaksi: json['kode_transaksi'],
      idPengguna: json['id_pengguna'],
      namaPengguna: json['nama_pengguna'],
      email: json['email'],
      noTelepon: json['no_telepon'],
      idAlamat: json['id_alamat'],
      idProduk: json['id_produk'],
      namaProduk: json['nama_produk'],
      merkProduk: json['merk_produk'],
      gambarProduk: json['gambar_produk'],
      hargaProduk: json['harga_produk'],
      deskripsiProduk: json['deskripsi_produk'],
      stokProduk: json['stok_produk'],
      quantity: json['quantity'],
      total: json['total'],
      createdAt: json['created_at'],
    );
  }
}
