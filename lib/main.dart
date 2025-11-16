import 'package:flutter/material.dart';
import 'package:union_shop/layouts/base_layout.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:go_router/go_router.dart';
import 'views/home.dart';

final _router = GoRouter(routes: [
  ShellRoute(
      builder: (context, state, child) => BaseLayout(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/product',
          builder: (context, state) => ProductPage(),
        ),
        GoRoute(
          path: '/collection/:collectionId',
          builder: (context, state) => ProductPage(),
        ),
        GoRoute(
          path: '/collections',
          builder: (context, state) => ProductPage(),
        )
      ])
]);

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      routerConfig: _router,
    );
  }
}
