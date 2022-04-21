import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_demo/features/shop_home/data/datasources/product_remote_data_source.dart';
import 'package:shop_demo/features/shop_home/data/models/product_data.dart';
import 'package:shop_demo/features/shop_home/data/repositories/product_data_repository_impl.dart';
import 'package:shop_demo/features/shop_home/domain/repositories/product_data_repository.dart';

import '../datasource/mock_data.dart';

class MockProductRemoteDataSource extends Mock
    implements ProductRemoteDataSource {
  @override
  Future<ProductData> getProductById(int? id) =>
      super.noSuchMethod(Invocation.method(#getProductById, [id]),
          returnValue:
              Future.value(ProductData.fromJson(json.decode(mockProductData))));

  @override
  Future<List<ProductData>> getAllProduct() => super.noSuchMethod(
      Invocation.method(#getAllProduct, []),
      returnValue: Future.value((json.decode(mockAllProductData) as Iterable)
          .map((e) => ProductData.fromJson(e))
          .toList()));

  @override
  Future<List<String>> getAllCategory() =>
      super.noSuchMethod(Invocation.method(#getAllCategory, []),
          returnValue: Future.value(json.decode(mockCategoryData)));

  @override
  Future<List<ProductData>> getProductsByCategory(String? category) =>
      super.noSuchMethod(Invocation.method(#getProductsByCategory, [category]),
          returnValue: Future.value(
              (json.decode(mockFiltedProductData) as Iterable)
                  .map((e) => ProductData.fromJson(e))
                  .toList()));
}

void main() {
  late MockProductRemoteDataSource productRemoteDataSource;
  late ProductDataRepository repository;

  group("product repository impltest", () {
    test("should get products when fetch all product", () async {
      productRemoteDataSource = MockProductRemoteDataSource();
      repository = ProductDataRepositoryImpl(productRemoteDataSource);
      when(repository.getProducts(true, null))
          .thenAnswer((_) async => productRemoteDataSource.getAllProduct());
      when(productRemoteDataSource.getAllProduct()).thenAnswer((_) =>
          Future.value((json.decode(mockAllProductData) as Iterable)
              .map((e) => ProductData.fromJson(e))
              .toList()));
      final result = await repository.getProducts(true, null);
      final expected = (json.decode(mockAllProductData) as Iterable)
          .map((e) => ProductData.fromJson(e))
          .toList();
      expect(result, equals(expected));
    });

    test("should get product when give id", () async {
      productRemoteDataSource = MockProductRemoteDataSource();
      repository = ProductDataRepositoryImpl(productRemoteDataSource);
      when(repository.getSingleProduct(0))
          .thenAnswer((_) async => productRemoteDataSource.getProductById(0));
      when(productRemoteDataSource.getProductById(0)).thenAnswer((_) =>
          Future.value(ProductData.fromJson(json.decode(mockProductData))));
      final result = await repository.getSingleProduct(0);
      final expected = ProductData.fromJson(json.decode(mockProductData));

      expect(result, equals(expected));
    });

    test("should get products with filtered category", () async {
      final cateogryString = "jewelry";
      productRemoteDataSource = MockProductRemoteDataSource();
      repository = ProductDataRepositoryImpl(productRemoteDataSource);
      when(repository.getProducts(false, cateogryString)).thenAnswer(
          (_) async =>
              productRemoteDataSource.getProductsByCategory(cateogryString));
      when(productRemoteDataSource.getProductsByCategory(cateogryString))
          .thenAnswer((_) async =>
              (json.decode(mockFiltedProductData) as Iterable)
                  .map((e) => ProductData.fromJson(e))
                  .toList());
      final result = await repository.getProducts(false, cateogryString);
      final expected = (json.decode(mockFiltedProductData) as Iterable)
          .map((e) => ProductData.fromJson(e))
          .toList();

      expect(result, equals(expected));
    });
  });
}
