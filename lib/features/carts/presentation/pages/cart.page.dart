import 'package:flutter/material.dart';
import 'package:mycatalog/features/carts/presentation/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context ) {
    var cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Belanja')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) =>
                  ListTile(leading: const Icon(Icons.fastfood), title: Text(cart.items[index].name)),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(20),
            child:  ElevatedButton(
              onPressed: () => cart.removeAll(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red), 
              child: const Text('Hapus Keranjang', style:  TextStyle(color: Colors.white))
              ),
              ),
        ],
      ),
    );
  }
}
  