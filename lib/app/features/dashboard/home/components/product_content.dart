part of home;

class _ProductContent extends StatelessWidget {
  const _ProductContent(this.data, {required this.onPressed, Key? key})
      : super(key: key);

  final data;
  final Function(dynamic product) onPressed;

  @override
  Widget build(BuildContext context) {
    // print(data);
    return FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final jsonResponse = snapshot.data as List<dynamic>;
            return Wrap(
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceBetween,
                children: List.generate(jsonResponse.length, (int index) {
                  // print(data[index]);
                  final data = jsonResponse[index] as Map<String, dynamic>;
                  return ProductCard(
                    heroTag: data["id_produk"],
                    data: ProductCardData(
                      id: int.parse(data['id_produk']),
                      image: data["gambar_produk"],
                      initialFavorite: true,
                      brand: data["merk_produk"],
                      name: data["nama_produk"],
                      price: double.parse(data['harga_produk']),
                    ),
                    onTap: () {
                      onPressed(data);
                    },
                  );
                }));
          } else {
            return Text("");
          }
        });
  }
}
