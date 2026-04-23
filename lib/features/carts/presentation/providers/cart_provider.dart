import 'package:flutter/material.dart';
import 'package:mycatalog/features/auth/data/models/product_model.dart';
import 'package:mycatalog/features/carts/domain/repositories/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository _repository;
  // Dependency Injection melalui constructor
  CartProvider({required CartRepository repository}) : _repository = repository;
  List<ProductModel> get items => _repository.getCartItems();
  void addItem(ProductModel product) {
    _repository.addItem(product);
    notifyListeners();
  }

  void removeAll() {
    _repository.removeAllItems();
    notifyListeners();
  }

  bool isInCart(int productId) => _repository.isItemInCart(productId);
}
