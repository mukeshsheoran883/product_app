import 'package:flutter/material.dart';
import 'package:product_app/model/product_mode.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailScreen({super.key, required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Product'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Image.network(widget.productModel.imgUrl.toString()),
            subtitle: Row(
              children: [
                const Text(
                  'Name : ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.productModel.name}",
                  style: const TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const Text(
                  'Price  : ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.productModel.price.toString(),
                  style: const TextStyle(fontSize: 25),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
