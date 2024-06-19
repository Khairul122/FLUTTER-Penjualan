class Category {
  final int idKategori;
  final String namaKategori;
  final List<Map<String, dynamic>> products;

  Category({required this.idKategori, required this.namaKategori, required this.products});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      idKategori: json['id_kategori'],
      namaKategori: json['nama_kategori'] ?? '',
      products: List<Map<String, dynamic>>.from(json['products'] ?? []),
    );
  }
}
