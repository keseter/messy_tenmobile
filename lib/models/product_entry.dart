// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(
    json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
  int? userId;
  String id;
  String name;
  int price;
  String description;
  String thumbnail;
  String category;
  bool isFeatured;
  DateTime createdAt;

  ProductEntry({
    required this.userId,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.isFeatured,
    required this.createdAt,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        userId: json["user_id"],
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"] ?? "",
        category: json["category"],
        isFeatured: json["is_featured"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
        "created_at": createdAt.toIso8601String(),
      };
}
