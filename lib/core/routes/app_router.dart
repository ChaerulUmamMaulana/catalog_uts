import 'package:flutter/material.dart';
import 'package:mycatalog/core/services/secure_storage.dart';
import 'package:mycatalog/core/theme/app_theme.dart';
import 'package:mycatalog/features/auth/data/presentation/pages/dashboard_page.dart';
import 'package:mycatalog/features/auth/data/presentation/pages/login_page.dart';
import 'package:mycatalog/features/auth/data/presentation/pages/register_page.dart';
import 'package:mycatalog/features/auth/data/presentation/pages/splash_page.dart';
import 'package:mycatalog/features/auth/data/presentation/pages/verify_email_page.dart';
import 'package:mycatalog/features/auth/data/presentation/providers/auth_provider.dart';
import 'package:mycatalog/features/auth/data/presentation/providers/product_provider.dart';
import 'package:mycatalog/features/carts/presentation/pages/cart.page.dart';
import 'package:provider/provider.dart';

class AppRouter { 
  static const String splash      = '/'; 
  static const String login       = '/login'; 
  static const String register    = '/register'; 
  static const String verifyEmail = '/verify-email'; 
  static const String dashboard   = '/dashboard';
  static const String cart        = '/cart'; 
 
  static Map<String, WidgetBuilder> get routes => { 
    splash:      (_) => const SplashPage(), 
    login:       (_) => const LoginPage(), 
    register:    (_) => const RegisterPage(), 
    verifyEmail: (_) => const VerifyEmailPage(), 
    dashboard:   (_) => const AuthGuard(child: DashboardPage()), 
    cart:        (_) => const AuthGuard(child: MyCart()),
  }; 
}

// Bungkus halaman yang butuh autentikasi dengan AuthGuard
class AuthGuard extends StatelessWidget {
  final Widget child;
  const AuthGuard({super.key, required this.child});


  @override
  Widget build(BuildContext context) {
    final status = context.watch<AuthProvider>().status;


    return switch (status) {
      AuthStatus.authenticated => child,           // Lanjut ke halaman
      AuthStatus.emailNotVerified =>
        const VerifyEmailPage(),                   // Redirect verifikasi
      _ => const LoginPage(),                     // Redirect login
    };
  }

}
 


// SplashPage: cek token tersimpan, redirect otomatis



// Penggunaan di routes:
// dashboard: (_) => const AuthGuard(child: DashboardPage())
//            ↑ DashboardPage HANYA muncul jika status = authenticated
