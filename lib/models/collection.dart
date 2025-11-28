import 'package:union_shop/models/product.dart';
import 'package:union_shop/repositories/product_repository.dart';

class Collection {
  final String title;
  final String id;
  final String description;
  final List<Product> products;

  Collection(
      {required this.title,
      required this.id,
      required this.products,
      required this.description});

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        products: (json["products"] as List<dynamic>)
            .map((v) => v.toString())
            .map((e) => ProductRepository.instance.getProduct(e))
            .whereType<Product>()
            .toList(),
      );
}
