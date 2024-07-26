class Customer {
  final String id;
  final String customerName;
 
  final String token;

  Customer(
      {required this.customerName,
     
      required this.token,
      required this.id});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        customerName: json["customerName"],
        token: json["token"],
      );
}
