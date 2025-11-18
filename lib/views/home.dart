import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/widgets/product_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero Section
        SizedBox(
          height: 400,
          width: double.infinity,
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ),
              // Content overlay
              Positioned(
                left: 24,
                right: 24,
                top: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Student Union Shop',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Shop student union merchandise",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () { context.go("/collections"); },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text(
                        'BROWSE PRODUCTS',
                        style: TextStyle(fontSize: 14, letterSpacing: 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Products Section
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                const Text(
                  'PRODUCTS SECTION',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 48),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 2 : 1,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 48,
                  children: const [
                    ProductCard(
                      title: 'Placeholder Product 1',
                      price: '£10.00',
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                    ),
                    ProductCard(
                      title: 'Placeholder Product 2',
                      price: '£15.00',
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                    ),
                    ProductCard(
                      title: 'Placeholder Product 3',
                      price: '£20.00',
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                    ),
                    ProductCard(
                      title: 'Placeholder Product 4',
                      price: '£25.00',
                      imageUrl:
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
