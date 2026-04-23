
import 'package:mycatalog/features/auth/data/models/product_model.dart';

abstract class CartRepository {
  List<ProductModel> getCartItems();
  void addItem(ProductModel product);
  void removeAllItems();
  bool isItemInCart(int productId);
}
