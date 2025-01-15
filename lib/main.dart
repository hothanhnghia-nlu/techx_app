import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:techx_app/pages/home/splash_screen.dart';
import 'package:techx_app/providers/address_provider.dart';
import 'package:techx_app/providers/auth_provider.dart';
import 'package:techx_app/providers/order_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
  try {
    // Cài đặt khóa Publishable Key của Stripe
    Stripe.publishableKey =
        "pk_test_51QXc1wIX5cpn4lFZvAVP13RXMxT1Xy4vxotGNxgetEeU0sGuVlBabeCrVOjBAEUSYI97AGYzpzh4MaVORFUfvCfx00HfXdWN8Z";
    await Stripe.instance.applySettings();
  } catch (e) {
    // In lỗi ra console (hoặc xử lý theo cách của bạn)
    print("Stripe initialization error: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechX',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
