class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;

  Product(
      {required this.id,
      required this.description,
      required this.price,
      required this.name,
      required this.image});
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"].toString(),
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: double.parse(json["price"].toString()),
      );
}
