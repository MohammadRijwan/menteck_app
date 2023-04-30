import 'package:flutter/material.dart';
import 'package:menteck_app/src/feature/cart/cart_screen.dart';
import 'package:menteck_app/src/feature/product/product_screen.dart';

class AppRouter {
  static const String productScreen = '/productScreen';
  static const String cartScreen = '/cartScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case productScreen:
        return MaterialPageRoute(builder: (_) => const ProductScreen());
      case cartScreen:
        return MaterialPageRoute(builder: (_) => const CartScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => RouteErrorScreen(
                  title: 'Route Not Found',
                  message: 'Error! The route ${settings.name} not found.',
                ));
    }
  }
}

class RouteErrorScreen extends StatelessWidget {
  final String title;
  final String message;

  const RouteErrorScreen({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
