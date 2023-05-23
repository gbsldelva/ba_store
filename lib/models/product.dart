import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  int id;
  String title;
  String category;
  String description;
  String image;
  double price;
  double rate;
  int count;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.image,
    required this.price,
    required this.rate,
    required this.count,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        category: json["category"],
        description: json["description"],
        image: json["image"],
        price: json["price"].toDouble(),
        rate: json["rating"]["rate"].toDouble(),
        count: json["rating"]["count"],
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category": category,
        "description": description,
        "image": image,
        "price": price,
        "rating": {"rate": rate, "count": count},
      };
}
