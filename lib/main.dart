import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/layouts/base_layout.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/views/cart_page.dart';
import 'package:union_shop/views/collection_page.dart';
import 'package:union_shop/views/collections_page.dart';
import 'package:union_shop/views/error_page.dart';
import 'package:union_shop/views/login_page.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/views/search_page.dart';
import 'views/home.dart';
import 'views/about.dart';

late final GoRouter _router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ProductRepository.instance.loadProducts();
  await CollectionRepository.instance
      .loadCollections(); // collections repository is dependent on products.

  _router = GoRouter(
      errorBuilder: (context, state) => BaseLayout(
          child: ErrorPage(
              errorMessage: state.error?.toString() ?? "Page not found")),
      routes: [
        ShellRoute(
            builder: (context, state, child) => BaseLayout(child: child),
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
              GoRoute(
                path: '/about',
                builder: (context, state) => const AboutPage(),
              ),
              GoRoute(
                  path: '/product/:productId',
                  builder: (context, state) {
                    if (state.pathParameters["productId"] == null ||
                        ProductRepository.instance.getProduct(
                                state.pathParameters["productId"]!) ==
                            null) {
                      throw GoError("Product not found");
                    }

                    return ProductPage(
                        product: ProductRepository.instance
                            .getProduct(state.pathParameters["productId"]!)!);
                  }),
              GoRoute(
                path: '/collection/:collectionId',
                builder: (context, state) {
                  if (state.pathParameters["collectionId"] == null ||
                      CollectionRepository.instance.getCollection(
                              state.pathParameters["collectionId"]!) ==
                          null) {
                    throw GoError("Collection not found");
                  }

                  return CollectionPage(
                      collection: CollectionRepository.instance.getCollection(
                          state.pathParameters["collectionId"]!)!);
                },
              ),
              GoRoute(
                path: '/collections',
                builder: (context, state) => const CollectionsPage(),
              ),
              GoRoute(
                path: '/login',
                builder: (context, state) => const LoginPage(),
              ),
              GoRoute(
                path: "/cart",
                builder: (context, state) => CartPage(),
              ),
              GoRoute(
                path: "/search",
                builder: (context, state) => const SearchPage(),
              )
            ])
      ]);

  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Cart(),
      child: MaterialApp.router(
        title: 'Union Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
        ),
        routerConfig: _router,
      ),
    );
  }
}
