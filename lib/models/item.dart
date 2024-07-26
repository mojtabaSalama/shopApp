class Item {
  final String id;

  final int amount;
  final double totalPrice;
  final String productId;

  Item(
      {required this.amount,
      required this.totalPrice,
      required this.id,
      required this.productId});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"].toString(),
        amount: json["amount"],
        totalPrice: double.parse(json["totalPrice"].toString()),
        productId: json["ProductId"].toString(),
      );
}
