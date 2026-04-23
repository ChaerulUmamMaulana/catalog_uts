import 'package:flutter/material.dart';
import 'package:mycatalog/features/auth/data/models/product_model.dart';
import 'package:mycatalog/features/carts/presentation/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class AddButtonWidget extends StatelessWidget {
final ProductModel product;
const AddButtonWidget({required this.product, super.key});
@override
Widget build(BuildContext context) {
final isInCart = context.select<CartProvider, bool>(
(provider) => provider.isInCart(product.id),
);
return TextButton(
onPressed: isInCart
? null
: () => context.read<CartProvider>().addItem(product),
child: isInCart
? const Icon(Icons.check, color: Colors.green)
: const Text('TAMBAH'),
);
}
}