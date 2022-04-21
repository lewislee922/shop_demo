import 'package:shop_demo/features/shop_home/domain/entities/product.dart';

abstract class ProductDataRepository {
  Future<Product> getSingleProduct(int id);
  Future<List<Product>> getProducts(bool? getAll, String? category);
  Future<List<String>> getAllCategory();
}
