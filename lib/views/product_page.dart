import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/slideshow_widget.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Product details
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: product.imageNames.length == 1
                      ? Image.asset(
                          "assets/images/products/${product.imageNames[0]}.png",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_not_supported,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Image unavailable',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Slideshow(imagePaths: product.imagePaths),
                ),
              ),

              const SizedBox(height: 24),

              // Product name
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 12),

              // Product price
              Row(
                children: [
                  Text(
                    "£${product.rrp.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: product.onSale ? Colors.grey : Colors.black,
                      decoration: product.onSale ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (product.onSale) ...[
                    const SizedBox(width: 8,),
                    Text(
                      "£${product.salePrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                      ),
                    )
                  ]
                ],
              ),

              const SizedBox(height: 24),

              // Product attributes
              if (product.productAttributes.isNotEmpty)
                ...product.productAttributes.entries.map((attribute) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          attribute.key,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          hint: Text('Select ${attribute.key}'),
                          items: attribute.value.entries.map((option) {
                            return DropdownMenuItem<String>(
                              value: option.key,
                              child: Text(option.value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            // Handle selection change
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),

              const SizedBox(
                height: 12,
              ),

              // Product description
              Text(
                'Description',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              // Skeleton for quantity to add
              Text(
                "Quantity",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                spacing: 4.0,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  const Text("0"),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.remove))
                ],
              ),

              ElevatedButton(onPressed: () {}, child: const Text("Add to cart"))
            ],
          ),
        ),
      ],
    );
  }
}
