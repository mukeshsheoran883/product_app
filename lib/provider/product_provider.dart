import 'package:flutter/foundation.dart';
import 'package:product_app/model/product_mode.dart';
import 'package:product_app/service/product_api.dart';
import 'package:product_app/service/shared_preference_service.dart';

class ProductProvider extends ChangeNotifier{

  late ProductApi productApi;
  List<ProductModel> productList = [];
  String? error;
  bool isLoading = false;
  bool isListView = true;

  Future loadProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      productApi = ProductApi();
      productList = await productApi.getProduct();
    } catch (e) {
      error = e.toString();
      if (kDebugMode) {
        print(error);
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future applyLayout() async {
    bool value = await SharedPrefService.getChange();
    isListView = value;
    notifyListeners();
  }

}