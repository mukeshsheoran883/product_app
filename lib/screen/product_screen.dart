import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:product_app/model/product_mode.dart';
import 'package:product_app/provider/product_provider.dart';
import 'package:product_app/service/product_api.dart';
import 'package:product_app/service/shared_preference_service.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  late ProductProvider productProvider;

  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    productProvider.productApi = ProductApi();
    productProvider.loadProducts();
    productProvider.applyLayout();});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductKart'),
        actions: [
          IconButton(
            onPressed: () {
              productProvider.isListView = productProvider.isListView;
              setState(() {});
              SharedPrefService.setChang(productProvider.isListView);
            },
            icon: Icon(
              productProvider.isListView
                  ? Icons.list
                  : Icons.grid_view_outlined,
              //  color: Colors.white,
            ),
          )
        ],
      ),
      body: Consumer<ProductProvider>(builder: (create, provider, widget) {
        return provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : provider.isListView
                ? buildListView()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: buildGridView(),
                  );
      }),
    );
  }

  GridView buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: Checkbox.width * 14.5,
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4),
      itemCount: productProvider.productList.length,
      itemBuilder: (context, index) {
        ProductModel productModel = productProvider.productList[index];
        return GestureDetector(

          child: Card(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {

                      },
                      icon: const Icon(Icons.edit),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          productProvider.isLoading = true;
                        });
                        try {
                          await productProvider.productApi
                              .deleteProduct(productModel.sId.toString());
                          await productProvider.loadProducts();
                        } catch (e) {
                          if (kDebugMode) {
                            print(e);
                          }
                        } finally {
                          setState(() {
                            productProvider.isLoading = false;
                          });
                        }
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
                Image.network(
                  productModel.imgUrl.toString(),
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                ListTile(
                  title: Text('Name : ${productModel.name}'),
                  subtitle: Text("Price : \$${productModel.price.toString()}"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: productProvider.productList.length,
      itemBuilder: (context, index) {
        ProductModel productModel = productProvider.productList[index];
        return GestureDetector(
          onTap: () {

          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {

                        },
                        icon: const Icon(Icons.edit),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            productProvider.isLoading = true;
                          });
                          try {
                            await productProvider.productApi
                                .deleteProduct(productModel.sId.toString());
                            await productProvider.loadProducts();
                          } catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
                          } finally {
                            setState(() {
                              productProvider.isLoading = false;
                            });
                          }
                        },
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                  Image.network(
                    productModel.imgUrl.toString(),
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  ListTile(
                    title: Text('Name : ${productModel.name}'),
                    subtitle:
                        Text("Price : \$${productModel.price.toString()}"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
