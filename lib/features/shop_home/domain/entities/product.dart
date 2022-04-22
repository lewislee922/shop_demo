import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String category;
  final String description;
  final String image;

  const Product(this.id, this.title, this.price, this.category,
      this.description, this.image);

  @override
  List<Object?> get props => [id];
}
