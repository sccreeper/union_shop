import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/repositories/collection_repository.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;

  const BaseLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: Text("Menu")),
            ListTile(
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
                context.go("/");
              },
            ),
            ExpansionTile(
              title: const Text("Shop"),
              children: CollectionRepository.instance
                  .getCollectionList()
                  .map((v) => ListTile(
                        title: Text(v.title),
                        onTap: () {
                          context.go("/collection/${v.id}");
                        },
                      ))
                  .toList(),
            ),
            ListTile(title: const Text("The Print Shack"), onTap: () {}),
            ListTile(
              title: const Text("Sale"),
              onTap: () {
                context.go("/collection/sale");
              },
            ),
            ListTile(
              title: const Text("About"),
              onTap: () {
                Navigator.pop(context);
                context.go("/about");
              },
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    color: Colors.white,
                    child: Column(
                      children: [
                        // Top banner
                        GestureDetector(
                          onTap: () {context.go("/collection/sale");},
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            color: const Color(0xFF4d2963),
                            child: const Text(
                              'SALE!',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),

                        // Main header
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.go('/');
                                  },
                                  child: Image.network(
                                    'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                    height: 18,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        width: 18,
                                        height: 18,
                                        child: const Center(
                                          child: Icon(Icons.image_not_supported,
                                              color: Colors.grey),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const Spacer(),
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 600),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.search,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        constraints: const BoxConstraints(
                                          minWidth: 32,
                                          minHeight: 32,
                                        ),
                                        onPressed: () {context.go("/search");},
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.person_outline,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        constraints: const BoxConstraints(
                                          minWidth: 32,
                                          minHeight: 32,
                                        ),
                                        onPressed: () {
                                          context.go("/login");
                                        },
                                      ),
                                      _CartButton(),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.menu,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        constraints: const BoxConstraints(
                                          minWidth: 32,
                                          minHeight: 32,
                                        ),
                                        onPressed: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 100 - 80,
                    ),
                    child: child,
                  ),

                  // Footer
                  Container(
                      width: double.infinity,
                      color: Colors.grey[50],
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        spacing: 8.0,
                        children: [
                          Column(
                            spacing: 4.0,
                            children: [
                              Text("Opening Hours",
                                  style: TextTheme.of(context).titleMedium),
                              const Text(
                                  "Term Time\nMonday - Friday 9am - 4pm"),
                              const Text(
                                  "Outside of Term Time\nMonday - Friday 9am - 3pm"),
                              const Text("Purchase online 24/7"),
                            ],
                          ),
                          Column(
                            spacing: 4.0,
                            children: [
                              Text(
                                "Help and information",
                                style: TextTheme.of(context).titleMedium,
                              ),
                              TextButton(
                                  onPressed: () => context.go("/search"),
                                  child: const Text("Search")),
                              TextButton(
                                  onPressed: () => {},
                                  child: const Text(
                                      "Terms & Conditions of Sale Policy"))
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Split out to avoid rebuilding widget tree every time the cart updates
class _CartButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClassButtonState();
}

class _ClassButtonState extends State<_CartButton> {
  @override
  void initState() {
    super.initState();

    final Cart cart = Provider.of<Cart>(context, listen: false);
    cart.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Badge.count(
        count: Provider.of<Cart>(context).totalItems,
        child: const Icon(
          Icons.shopping_bag_outlined,
          size: 18,
          color: Colors.grey,
        ),
      ),
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(
        minWidth: 32,
        minHeight: 32,
      ),
      onPressed: () {
        context.go("/cart");
      },
    );
  }
}
