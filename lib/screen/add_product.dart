import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product_app/model/product_mode.dart';
import 'package:product_app/service/product_api.dart';



class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController addImage = TextEditingController();
  TextEditingController addName = TextEditingController();
  TextEditingController addPrice = TextEditingController();
  TextEditingController addDescription = TextEditingController();
  TextEditingController addRating = TextEditingController();

  Future addProduct() async {
    ProductModel productModel = ProductModel(
        name: addName.text,
        imgUrl: addImage.text,
        price: int.parse(addPrice.text),
        description: addDescription.text);
    try {
      ProductApi productApi = ProductApi();
      await productApi.addProduct(productModel);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
        'Add Product',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            TextFormField(
              controller: addImage,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Image',
              ),
            ),
            TextFormField(
              controller: addName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            TextFormField(
              controller: addPrice,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Price',
              ),
            ),
            TextFormField(
              controller: addDescription,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                addProduct();
                Navigator.pop(context);
              },
              child: const Text('Add Product'),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

