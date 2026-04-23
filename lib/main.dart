import 'package:firebase_core/firebase_core.dart';
import 'package:mycatalog/core/routes/app_router.dart';
import 'package:mycatalog/core/theme/app_theme.dart';
import 'package:mycatalog/features/auth/data/presentation/providers/auth_provider.dart';
import 'package:mycatalog/features/carts/presentation/providers/cart_provider.dart';
import 'features/carts/data/repositories/cart_repository_impl.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/data/presentation/providers/product_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider(repository: CartRepositoryImpl())),
      ], 
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
 ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        title:                  'My App',
        debugShowCheckedModeBanner: false,
        theme:                  AppTheme.light,
        initialRoute:           AppRouter.splash,
        routes:                 AppRouter.routes,
      ),
    );
  }
}


