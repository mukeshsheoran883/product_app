import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product_app/model/product_mode.dart';
import 'package:product_app/service/product_api.dart';

class UpdateProduct extends StatefulWidget {
  final ProductModel productModel;

  const UpdateProduct({super.key, required this.productModel});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController updateImage = TextEditingController();
  TextEditingController updateName = TextEditingController();
  TextEditingController updatePrice = TextEditingController();
  TextEditingController updateDescription = TextEditingController();

  @override
  void initState() {
    ProductModel productModel = widget.productModel;
    updateImage.text = productModel.imgUrl ?? '';
    updateName.text = productModel.name ?? '';
    updatePrice.text = productModel.price?.toString() ?? '';
    updateDescription.text = productModel.description ?? '';
    super.initState();
  }

  Future update() async {
    ProductModel productModel = ProductModel(
        sId: widget.productModel.sId,
        name: updateName.text,
        imgUrl: updateImage.text,
        price: int.parse(updatePrice.text),
        description: updateDescription.text);
    try {
      ProductApi productApi = ProductApi();
      await productApi.updateProduct(productModel);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Product',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(key: globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                controller: updateImage,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Image',
                ),
              ),
              TextFormField(
                controller: updateName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: updatePrice,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                ),
              ),
              TextFormField(
                controller: updateDescription,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  update();
                  Navigator.pop(context);
                },
                child: const Text('Update Product'),
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
