class Product {
  final int productId;
  final String productName;
  final int qty;
  final int price;

  Product({required this.productId, required this.productName, required this.qty, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      productName: json['productName'],
      qty: json['qty'],
      price: json['price'],
    );
  }
}
