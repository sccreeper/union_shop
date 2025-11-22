import 'package:flutter/material.dart';
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
          Text("Collections", style: Theme.of(context).textTheme.headlineLarge,),
          GridView.count(
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              CollectionCard(
                title: "Collection 1", 
                id: "collection-1", 
                backgroundImage: Image.network("https://shop.upsu.net/cdn/shop/files/SageHoodie_1512x.png?v=1745583498").image
              ),
              CollectionCard(
                title: "Collection 2", 
                id: "collection-2", 
                backgroundImage: Image.network("https://shop.upsu.net/cdn/shop/files/SageHoodie_1512x.png?v=1745583498").image
              ),
              CollectionCard(
                title: "Collection 2", 
                id: "collection-2", 
                backgroundImage: Image.network("https://shop.upsu.net/cdn/shop/files/SageHoodie_1512x.png?v=1745583498").image
              ),
              CollectionCard(
                title: "Collection 3", 
                id: "collection-3", 
                backgroundImage: Image.network("https://shop.upsu.net/cdn/shop/files/SageHoodie_1512x.png?v=1745583498").image
              )
            ],
          ),
        ],
      ),
    );
  }
}