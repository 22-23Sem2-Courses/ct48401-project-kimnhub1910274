import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../models/product.dart';

class ProductManager with ChangeNotifier {
  Future<void> fetchProducts([bool filterByUser = false]) async {
    // _items = await _productsService.fetchProducts(filterByUser);
    notifyListeners();
  }

  List<Product> _items = [];
  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }
}