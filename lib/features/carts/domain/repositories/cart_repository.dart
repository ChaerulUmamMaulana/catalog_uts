
abstract class CartRepository {
  List<Product> getCartItems();
  void addItem(Product product);
  void removeAllItems();
  bool isItemInCart(int productId);
}
