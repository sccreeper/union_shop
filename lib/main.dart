import 'package:flutter/material.dart';
import 'package:union_shop/layouts/base_layout.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/views/collection_page.dart';
import 'package:union_shop/views/collections_page.dart';
import 'package:union_shop/views/login_page.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:go_router/go_router.dart';
import 'views/home.dart';
import 'views/about.dart';

final _router = GoRouter(routes: [
  ShellRoute(
      builder: (context, state, child) => BaseLayout(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => AboutPage(),
        ),
        GoRoute(
          path: '/product/:productId',
          builder: (context, state) => ProductPage(product: Product(
            name: "A product", 
            description: "Some product idk", 
            rrp: 4.00, 
            id: "a-product", 
            productAttributes: {"Size": {"xs":"XS", "s":"S", "m":"M"}}
          ),),
        ),
        GoRoute(
          path: '/collection/:collectionId',
          builder: (context, state) => const CollectionPage(),
        ),
        GoRoute(
          path: '/collections',
          builder: (context, state) => CollectionsPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
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
