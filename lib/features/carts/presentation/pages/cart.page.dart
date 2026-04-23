import 'package:flutter/material.dart';
import 'package:mycatalog/features/carts/presentation/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context ) {
    var cart = context.watch<CartProvider>();

     double totalHarga = cart.items.fold(
      0,
      (sum, item) => sum + item.price,
    );


    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Belanja')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) =>
                  ListTile(
                    leading: const Icon(Icons.gamepad), title: Text(cart.items[index].name),
                    subtitle: Text('Rp ${cart.items[index].price.toStringAsFixed(0)}'),
                  ),
            ),
          ),
          const Divider(),

              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp ${totalHarga.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child:  Row(
              children: [
              
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => cart.removeAll(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      'Hapus Keranjang',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // nanti bisa kamu isi logic pembayaran
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur pembayaran belum dibuat'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text(
                      'Bayar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
              ),
        ],
      ),
    );
  }
}
  