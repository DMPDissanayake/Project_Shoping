import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_cart/Pages/product_page.dart';
import 'package:shoping_cart/Provider/cart_provider.dart';
import 'package:shoping_cart/Provider/fave_provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => FavoProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}
