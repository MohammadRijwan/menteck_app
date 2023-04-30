import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menteck_app/src/core/dependency/dependency_injection.dart';
import 'package:menteck_app/src/core/utils/app_router.dart';
import 'package:menteck_app/src/feature/product/product_screen.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setupDependencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E Commerce',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
      home: OrientationBuilder(builder: (context, orientation) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
        return const ProductScreen();
      }),
    );
  }
}
