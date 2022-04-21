import 'package:http/http.dart';
import 'package:shop_demo/core/error/failure.dart';
import 'package:shop_demo/features/shop_home/data/datasources/product_remote_data_source.dart';
import 'package:shop_demo/features/shop_home/domain/entities/product.dart';
import 'package:shop_demo/features/shop_home/domain/repositories/product_data_repository.dart';

class ProductDataRepositoryImpl implements ProductDataRepository {
  final ProductRemoteDataSource dataSource;

  ProductDataRepositoryImpl(this.dataSource);

  @override
  Future<List<Product>> getProducts(bool? getAll, String? category) async {
    try {
      if (getAll == true) {
        final _data = await dataSource.getAllProduct();
        return _data;
      }
      if (category != null) {
        final _data = await dataSource.getProductsByCategory(category);
        return _data;
      }
    } catch (e) {
      rethrow;
    }
    throw NoDataFailure();
  }

  @override
  Future<Product> getSingleProduct(int id) async {
    try {
      final _data = await dataSource.getProductById(id);
      return _data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getAllCategory() async {
    try {
      final _data = await dataSource.getAllCategory();
      return _data;
    } catch (e) {
      rethrow;
    }
  }
}
