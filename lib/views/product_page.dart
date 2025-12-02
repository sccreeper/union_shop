import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/slideshow_widget.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({super.key, required this.product});

  @override
  State<StatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity = 1;
  Map<String, String> selectedAttributes = {};

  @override
  void initState() {
    super.initState();

    for (var entry in widget.product.productAttributes.entries) {
      if (entry.value.isNotEmpty) {
        selectedAttributes[entry.key] = entry.value.keys.first;
      }
    }
  }

  void _addToCart() {
    final Cart cart = Provider.of<Cart>(context, listen: false);
    cart.addItem(CartItem(
        product: widget.product,
        attributes: selectedAttributes,
        quantity: quantity));

    final SnackBar snackBar = SnackBar(
      content: Text("Added $quantity ${widget.product.name} to cart"),
      action: SnackBarAction(
          label: "View cart",
          onPressed: () {
            context.go("/cart");
          }),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (quantity - 1 > 0) {
        quantity--;
      }
    });
  }

  void _setAttribute(String key, String value) {
    selectedAttributes[key] = value;
  }

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
                  child: widget.product.imageNames.length == 1
                      ? Image.asset(
                          "assets/images/products/${widget.product.imageNames[0]}.png",
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
                      : Slideshow(imagePaths: widget.product.imagePaths),
                ),
              ),

              const SizedBox(height: 24),

              // Product name
              Text(
                widget.product.name,
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
                    "£${widget.product.rrp.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: widget.product.onSale ? Colors.grey : Colors.black,
                      decoration: widget.product.onSale
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  if (widget.product.onSale) ...[
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "£${widget.product.salePrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )
                  ]
                ],
              ),

              const SizedBox(height: 24),

              // Product attributes
              if (widget.product.productAttributes.isNotEmpty)
                ...widget.product.productAttributes.entries.map((attribute) {
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
                          initialValue: attribute.value.entries.first.key,
                          hint: Text('Select ${attribute.key}'),
                          items: attribute.value.entries.map((option) {
                            return DropdownMenuItem<String>(
                              value: option.key,
                              child: Text(option.value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              _setAttribute(attribute.key, value);
                            }
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
                widget.product.description,
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
                  IconButton(
                      onPressed: _increaseQuantity,
                      icon: const Icon(Icons.add)),
                  Text(quantity.toString()),
                  IconButton(
                      onPressed: _decreaseQuantity,
                      icon: const Icon(Icons.remove))
                ],
              ),

              ElevatedButton(
                  onPressed: _addToCart, child: const Text("Add to cart"))
            ],
          ),
        ),
      ],
    );
  }
}
