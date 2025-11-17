import 'package:union_shop/models/product.dart';

class Collection {
  final String title;
  final String id;
  late List<Product> products;

  Collection({required this.title, required this.id, required this.products});
  
}