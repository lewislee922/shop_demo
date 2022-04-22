import 'package:shop_demo/features/shop_home/domain/entities/product.dart';

class ProductData extends Product {
  const ProductData(int id, String title, double price, String category,
      String description, String image)
      : super(id, title, price, category, description, image);

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
      json['id'],
      json['title'],
      double.parse(json['price'].toString()),
      json['category'],
      json['description'],
      json['image']);
}
