import 'package:flutter/material.dart';

class ItemOrderData {
  final int id;
  final String image;
  final bool initialFavorite;
  final String brand;
  final String name;
  final double price;

  ItemOrderData({
    required this.id,
    required this.image,
    required this.initialFavorite,
    required this.brand,
    required this.name,
    required this.price,
  });
}

class ItemOrder extends StatelessWidget {
  final String heroTag;
  final ItemOrderData data;
  final VoidCallback onTap;

  const ItemOrder({
    Key? key,
    required this.heroTag,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Image.network(data.image),
            Text(data.name),
            Text(data.brand),
            Text('${data.price}'),
          ],
        ),
      ),
    );
  }
}
