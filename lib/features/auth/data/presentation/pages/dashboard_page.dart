import 'package:flutter/material.dart';
import 'package:mycatalog/features/auth/data/presentation/providers/auth_provider.dart';
import 'package:mycatalog/features/auth/data/presentation/providers/product_provider.dart';
import 'package:mycatalog/features/carts/presentation/widgets/add_button_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../core/routes/app_router.dart';
import 'package:mycatalog/core/providers/theme_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final product = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dashboard', style: TextStyle(fontSize: 18)),
            Text(
              'Halo, ${auth.firebaseUser?.displayName ?? 'User'}!',
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: [

           IconButton(
    icon: const Icon(Icons.person),
    onPressed: () {
      showDialog(
        context: context,
        builder: (_) => const AccountDialog(),
      );
    },
  ),

        IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.logout();
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, AppRouter.login);
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, AppRouter.cart),
          ),

           IconButton(
    icon: const Icon(Icons.shopping_cart),
    onPressed: () {
      Navigator.pushNamed(
        context,
        AppRouter.cart,
      );
    },
  ),
        ],
      ),
      body: switch (product.status) {
        ProductStatus.loading || ProductStatus.initial => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Memuat produk...'),
              ],
            ),
          ),
        ProductStatus.error => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(product.error ?? 'Terjadi kesalahan'),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Coba Lagi'),
                  onPressed: () => product.fetchProducts(),
                ),
              ],
            ),
          ),
        ProductStatus.loaded => RefreshIndicator(
            onRefresh: () => product.fetchProducts(),
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: product.products.length,
              itemBuilder: (context, i) {
                final p = product.products[i];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Image.asset(
                          p.imageUrl,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 120,
                            color: Colors.blueAccent.shade200,
                            child:
                                const Icon(Icons.image_not_supported, size: 40),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Text('Rp ${p.price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                    color: Color(0xFF1565C0),
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(p.category,
                                  style: const TextStyle(
                                      fontSize: 11, color: Color(0xFF1565C0))),
                            ),
                            AddButtonWidget(product: p)
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      },
    );
  }
}

class AccountDialog extends StatelessWidget {
  const AccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    final isDark = themeProvider.isDark;

    return AlertDialog(
      title: const Text("Akun"),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Row(
            children: [

              Icon(
                isDark
                    ? Icons.dark_mode
                    : Icons.light_mode,

                color: isDark
                    ? Colors.amber
                    : Colors.orange,
              ),

              const SizedBox(width: 10),

              Text(
                isDark
                    ? "Dark Mode"
                    : "Light Mode",
              ),
            ],
          ),

          const SizedBox(height: 20),

          SwitchListTile(
            title: const Text("Aktifkan Dark Mode"),

            value: isDark,

            onChanged: (value) {
              context.read<ThemeProvider>().toggle();
            },
          ),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Tutup"),
        ),
      ],
    );
  }
}
