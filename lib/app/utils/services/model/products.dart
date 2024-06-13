class Pembayaran {
  final int id_pembayaran;
  final String kode_transaksi;
  final int id_pengguna;
  final int id_produk;
  final String nama_produk;
  final double harga_produk;
  final int quantity;
  final double total;
  final String created_at;
  final String gambar_produk;

  Pembayaran({
    required this.id_pembayaran,
    required this.kode_transaksi,
    required this.id_pengguna,
    required this.id_produk,
    required this.nama_produk,
    required this.harga_produk,
    required this.quantity,
    required this.total,
    required this.created_at,
    required this.gambar_produk,
  });

  factory Pembayaran.fromJson(Map<String, dynamic> json) {
    return Pembayaran(
      id_pembayaran: int.parse(json['id_pembayaran'].toString()),
      kode_transaksi: json['kode_transaksi'],
      id_pengguna: int.parse(json['id_pengguna'].toString()),
      id_produk: int.parse(json['id_produk'].toString()),
      nama_produk: json['nama_produk'],
      harga_produk: double.parse(json['harga_produk'].toString()),
      quantity: int.parse(json['quantity'].toString()),
      total: double.parse(json['total'].toString()),
      created_at: json['created_at'],
      gambar_produk: json['gambar_produk'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pembayaran': id_pembayaran,
      'kode_transaksi': kode_transaksi,
      'id_pengguna': id_pengguna,
      'id_produk': id_produk,
      'nama_produk': nama_produk,
      'harga_produk': harga_produk,
      'quantity': quantity,
      'total': total,
      'created_at': created_at,
      'gambar_produk': gambar_produk,
    };
  }
}
