import 'package:flutter/material.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/widgets/collection_card.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 4.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Collections",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          GridView.count(
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: CollectionRepository.instance
                .getCollectionList()
                .map((v) => CollectionCard(
                    title: v.title,
                    id: v.id,
                    backgroundImage:
                        Image.asset("assets/images/collections/${v.id}.png")
                            .image))
                .toList(),
          ),
        ],
      ),
    );
  }
}
