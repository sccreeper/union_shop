class Product {
  final String name;
  final String description;
  final double rrp;
  final double salePrice;
  final String id;
  final List<String> imageNames;

  final Map<String, Map<String, String>> productAttributes;

  Product(
      {required this.name,
      required this.description,
      required this.rrp,
      required this.id,
      required this.productAttributes,
      required this.imageNames,
      this.salePrice = 0.00});

  double get truePrice {
    if (salePrice == 0.00) {
      return rrp;
    }

    return salePrice;
  }

  bool get onSale {
    return salePrice == 0.00;
  }

  List<String> get imagePaths =>
      imageNames.map((v) => "assets/images/products/$v.png").toList();

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      name: json["name"],
      description: json["description"],
      rrp: json["rrp"],
      salePrice: json["salePrice"],
      id: json["id"],
      imageNames: (json["imageNames"] as List<dynamic>)
          .map((v) => v.toString())
          .toList(),
      productAttributes: (json["productAttributes"] as Map<String, dynamic>)
          .map((k, v) => MapEntry(
              k,
              (v as Map<String, dynamic>).map(
                  (innerK, innerV) => MapEntry(innerK, innerV.toString())))));
}
