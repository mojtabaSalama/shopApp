class Order {
  final String id;

  final int totalAmount;
  final double totalPrice;
  final DateTime createdAt;

  Order(
      {required this.totalAmount,
      required this.totalPrice,
      required this.id,
      required this.createdAt});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"].toString(),
        totalAmount: json["totalAmount"],
        totalPrice: double.parse(json["totalPrice"].toString()),
        createdAt: DateTime.parse(json["createdAt"]),
      );
}
