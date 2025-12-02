import 'package:flutter/material.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/product_card_widget.dart';

enum FilterBy {
  allProducts,
  onSale,
}

enum SortBy {
  alphabeticallyAZ,
  alphabeticallyZA,
  priceLowHigh,
  priceHighLow,
}

class CollectionPage extends StatefulWidget {
  final Collection collection;

  const CollectionPage({super.key, required this.collection});

  @override
  State<StatefulWidget> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  SortBy _sortBy = SortBy.priceLowHigh;
  FilterBy _filterBy = FilterBy.allProducts;

  late List<Product> _productsCopy;

  List<DropdownMenuItem<SortBy>> _buildSortByEntries() => SortBy.values
      .map((v) => DropdownMenuItem(
            value: v,
            child: Text(v.name),
          ))
      .toList();

  List<DropdownMenuItem<FilterBy>> _buildFilterByEntries() => FilterBy.values
      .map((v) => DropdownMenuItem(
            value: v,
            child: Text(v.name),
          ))
      .toList();

  void _filter(FilterBy filterMode) {
    _filterBy = filterMode;

    if (filterMode == FilterBy.onSale) {
      List<Product> temp = [];

      for (Product product in _productsCopy) {
        if (product.onSale) {
          temp.add(product);
        }
      }

      setState(() {
        _productsCopy = [...temp];
      });
    } else {
      setState(() {
        _productsCopy = [...widget.collection.products];
      });
    }
  }

  void _sort(SortBy sortMode) {

    _sortBy = sortMode;

    _productsCopy.sort((a,b) {
      switch (_sortBy) {
        case SortBy.priceLowHigh:
          return a.truePrice.compareTo(b.truePrice);
        case SortBy.priceHighLow:
          return b.truePrice.compareTo(a.truePrice);
        case SortBy.alphabeticallyAZ:
          return a.name.compareTo(b.name);
        case SortBy.alphabeticallyZA:
          return b.name.compareTo(a.name);
        default:
          return 0;
      }
    });

    setState(() {});

  }

  @override
  void initState() {
    super.initState();

    _productsCopy = [...widget.collection.products];
    _sort(_sortBy);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Header
          Column(
            children: [
              Text(
                widget.collection.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 8.0,
              ),
              // Filter/inputs row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 4.0,
                  children: [
                    SizedBox(
                      width: 150,
                      child: DropdownButtonFormField<FilterBy>(
                        onChanged: (value) {_filter(value ?? FilterBy.allProducts);},
                        initialValue: _filterBy,
                        items: _buildFilterByEntries(),
                        hint: const Text("Filter By"),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: DropdownButtonFormField<SortBy>(
                        onChanged: (value) {_sort(value ?? SortBy.priceLowHigh);},
                        initialValue: _sortBy,
                        items: _buildSortByEntries(),
                        hint: const Text("Sort By"),
                      ),
                    ),
                    Text("${_productsCopy.length} Products")
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 4.0,
          ),
          GridView.count(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: _productsCopy
                  .map((v) => ProductCard(
                        product: v,
                      ))
                  .toList())
        ],
      ),
    );
  }
}
