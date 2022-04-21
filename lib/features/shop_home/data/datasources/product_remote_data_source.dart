import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/failure.dart';
import '../models/product_data.dart';

abstract class ProductRemoteDataSource {
  Future<ProductData> getProductById(int id);
  Future<List<ProductData>> getAllProduct();
  Future<List<ProductData>> getProductsByCategory(String category);
  Future<List<String>> getAllCategory();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Client client;
  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<String>> getAllCategory() async {
    final response = await client
        .get(Uri.parse("https://fakestoreapi.com/products/categories"));

    switch (response.statusCode) {
      case 200:
        if (response.body.isNotEmpty) {
          final _data = json.decode(response.body);

          return List<String>.from(_data);
        }
        throw NoDataFailure();
      default:
        throw NetworkFailure();
    }
  }

  @override
  Future<List<ProductData>> getAllProduct() async {
    final response =
        await client.get(Uri.parse("https://fakestoreapi.com/products"));

    switch (response.statusCode) {
      case 200:
        if (response.body.isNotEmpty) {
          Iterable _data = json.decode(response.body) as Iterable;

          return _data.map((e) => ProductData.fromJson(e)).toList();
        }
        throw NoDataFailure();
      default:
        throw NetworkFailure();
    }
  }

  @override
  Future<List<ProductData>> getProductsByCategory(String category) async {
    final response = await client
        .get(Uri.parse("https://fakestoreapi.com/products/category/$category"));

    switch (response.statusCode) {
      case 200:
        if (response.body.isNotEmpty) {
          Iterable _data = json.decode(response.body);

          return _data.map((e) => ProductData.fromJson(e)).toList();
        }
        throw NoDataFailure();
      default:
        throw NetworkFailure();
    }
  }

  @override
  Future<ProductData> getProductById(int id) async {
    final response =
        await client.get(Uri.parse("https://fakestoreapi.com/products/$id"));

    switch (response.statusCode) {
      case 200:
        if (response.body.isNotEmpty) {
          final _data = json.decode(response.body) as Map<String, dynamic>;

          return ProductData.fromJson(_data);
        }
        throw NoDataFailure();
      default:
        throw NetworkFailure();
    }
  }
}
