class Product {
  final String name;
  final String description;
  final double rrp;
  final double salePrice;
  final String id;

  final Map<String, Map<String, String>> productAttributes;

  Product(
      {required this.name,
      required this.description,
      required this.rrp,
      required this.id,
      required this.productAttributes,
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
}