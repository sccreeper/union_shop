import 'package:flutter/material.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/widgets/header_slideshow.dart';
import 'package:union_shop/widgets/product_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero Section
        const SizedBox(
            height: 400,
            width: double.infinity,
            child: HeaderSlideshow(slideshowItems: [
              HeaderSlideshowItem(
                  title: "Union Shop",
                  subtitle: "Shop union merchandise",
                  buttonText: "Shop now",
                  route: "/collections",
                  imagePath: "assets/images/products/badge-pin-1-crest.png"),
              HeaderSlideshowItem(
                  title: "Sale",
                  subtitle: "Up to 50% off",
                  buttonText: "Shop sale",
                  route: "/collection/sale",
                  imagePath: "assets/images/products/cap-1.png"),
              HeaderSlideshowItem(
                  title: "Clothing",
                  subtitle: "Get some union clothing",
                  buttonText: "Shop clothing",
                  route: "/collection/clothing",
                  imagePath: "assets/images/products/t-shirt-1.png")
            ])),

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
                    children: ProductRepository.instance.productEntries
                        .map((v) => ProductCard(product: v))
                        .toList()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
