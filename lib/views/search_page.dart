import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/widgets/paginated.dart';
import 'package:union_shop/widgets/product_card_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> _results = [];

  void _search(String query) {
    setState(() {
      _results = ProductRepository.instance.query(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            key: const Key("search-field"),
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Search"),
            onChanged: _search,
          ),
          const SizedBox(
            height: 8.0,
          ),
          if(_results.isNotEmpty)
            ...[Paginated(
              perPage: 4,
              children: _results.map((v) => ProductCard(product: v)).toList(),
            )]
          else
            ...[
              const Center(
                child: Text("No search results"),
              )
            ]
        ],
      ),
    );
  }
}
