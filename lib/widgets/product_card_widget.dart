import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go("/product/${product.id}");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              "assets/images/products/${product.imageNames[0]}.png",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                product.name,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "£${product.rrp.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 13,
                      color: product.onSale ? Colors.grey : Colors.black,
                      decoration:
                          product.onSale ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (product.onSale) ...[
                    const SizedBox(width: 4.0,),
                    Text(
                      "£${product.salePrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    )
                  ]
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
