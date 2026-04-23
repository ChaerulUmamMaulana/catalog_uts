
import 'package:mycatalog/features/auth/data/models/product_model.dart';
import 'package:mycatalog/features/carts/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final List<ProductModel> _items = [];
  @override
  List<ProductModel> getCartItems() => List.unmodifiable(_items);
  @override
  void addItem(ProductModel product) => _items.add(product);
  @override
  bool isItemInCart(int productId) => _items.any((p) => p.id == productId);
  
  @override
  void removeAllItems() {
     _items.clear();
  }
}