import 'dart:convert';

ProductRes productResFromJson(String str) =>
    ProductRes.fromJson(json.decode(str));

String productResToJson(ProductRes data) => json.encode(data.toJson());

class ProductRes {
  int? status;
  String? message;
  int? totalRecord;
  int? totalPage;
  List<Product>? products;

  ProductRes({
    this.status,
    this.message,
    this.totalRecord,
    this.totalPage,
    this.products,
  });

  factory ProductRes.fromJson(Map<String, dynamic> json) => ProductRes(
        status: json["status"],
        message: json["message"],
        totalRecord: json["totalRecord"],
        totalPage: json["totalPage"],
        products: json["data"] != null
            ? List<Product>.from(json["data"].map((x) => Product.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalRecord": totalRecord,
        "totalPage": totalPage,
        "data": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  int? id;
  String? slug;
  String? title;
  String? description;
  int? price;
  String? featuredImage;
  String? status;
  DateTime? createdAt;

  Product({
    this.id,
    this.slug,
    this.title,
    this.description,
    this.price,
    this.featuredImage,
    this.status,
    this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        slug: json["slug"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        featuredImage: json["featured_image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "description": description,
        "price": price,
        "featured_image": featuredImage,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
      };
}
