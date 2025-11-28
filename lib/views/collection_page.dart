import 'package:flutter/material.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/widgets/product_card_widget.dart';

enum FilterByType {
  allProducts,
}

enum SortByType {
  bestSelling,
  alphabeticallyAZ,
  alphabeticallyZA,
  priceLowHigh,
  priceHighLow,
  dateOldNew,
  dateNewOld,
}

class CollectionPage extends StatelessWidget {
  final Collection collection;

  const CollectionPage({super.key, required this.collection});

  List<DropdownMenuEntry<SortByType>> _buildSortByEntries() {
    List<DropdownMenuEntry<SortByType>> entries = [];

    for (SortByType sortBy in SortByType.values) {
      DropdownMenuEntry<SortByType> newEntry =
          DropdownMenuEntry(value: sortBy, label: sortBy.name);

      entries.add(newEntry);
    }

    return entries;
  }

  List<DropdownMenuEntry<FilterByType>> _buildFilterByEntries() {
    List<DropdownMenuEntry<FilterByType>> entries = [];

    for (FilterByType filterBy in FilterByType.values) {
      DropdownMenuEntry<FilterByType> newEntry =
          DropdownMenuEntry(value: filterBy, label: filterBy.name);

      entries.add(newEntry);
    }

    return entries;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Header
          Container(
            decoration:
                const BoxDecoration(border: Border(bottom: BorderSide())),
            child: Column(
              children: [
                Text(
                  collection.title,
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
                        child: DropdownMenu(
                          dropdownMenuEntries: _buildFilterByEntries(),
                          label: const Text("Filter By"),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: DropdownMenu(
                          dropdownMenuEntries: _buildSortByEntries(),
                          label: const Text("Sort By"),
                        ),
                      ),
                      const Text("n Products")
                    ],
                  ),
                )
              ],
            ),
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
            children: collection.products.map((v) => ProductCard(product: v,)).toList()
          )
        ],
      ),
    );
  }
}
