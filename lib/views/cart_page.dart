import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    final Cart cart = Provider.of<Cart>(context, listen: false);
    cart.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _increaseQuantity(int index) {
    if (!mounted) return;
    final Cart cart = Provider.of<Cart>(context, listen: false);
    setState(() {
      cart.setQuantity(index, cart.getQuantity(index) + 1);
    });
  }

  void _decreaseQuantity(int index) {
    if (!mounted) return;
    final Cart cart = Provider.of<Cart>(context, listen: false);
    setState(() {
      cart.setQuantity(index, cart.getQuantity(index) - 1);
    });
  }

  void _removeItem(int index) {
    if (!mounted) return;
    final Cart cart = Provider.of<Cart>(context, listen: false);
    setState(() {
      cart.removeItem(index);
    });
  }

  void _checkout() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Order placed!")));

    context.go("/");

    final Cart cart = Provider.of<Cart>(context, listen: false);
    cart.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (Provider.of<Cart>(context).isEmpty) ...[
            Text(
              "Your cart is empty.",
              style: TextTheme.of(context).bodyLarge,
            ),
            ElevatedButton(
                onPressed: () {
                  context.go("/collections");
                },
                child: const Text("Continue shopping"))
          ] else ...[
            ...Provider.of<Cart>(context).items.asMap().entries.map((entry) {
              CartItem v = entry.value;
              int index = entry.key;

              return Container(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          v.product.name,
                          style: TextTheme.of(context).titleSmall,
                        ),
                        Text(v.attributes.entries.fold(
                            "",
                            (previousValue, element) =>
                                "$previousValue ${element.key} ${element.value}, "))
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                            "£${v.product.truePrice.toStringAsFixed(2)} x ${v.quantity} (£${(v.product.truePrice * v.quantity).toStringAsFixed(2)})"),
                        const SizedBox(
                          width: 2.0,
                        ),
                        IconButton(
                            onPressed: () {
                              _decreaseQuantity(index);
                            },
                            icon: const Icon(Icons.remove)),
                        const SizedBox(
                          width: 2.0,
                        ),
                        IconButton(
                            onPressed: () {
                              _increaseQuantity(index);
                            },
                            icon: const Icon(Icons.add)),
                        const SizedBox(
                          width: 4.0,
                        ),
                        IconButton(
                            onPressed: () {
                              _removeItem(index);
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            Text("${Provider.of<Cart>(context).totalItems} items"),
            Text(
                "Total: £${Provider.of<Cart>(context).totalPrice.toStringAsFixed(2)}"),
            const SizedBox(height: 8,),
            ElevatedButton(onPressed: _checkout, child: const Text("Checkout"))
          ]
        ],
      ),
    );
  }
}
