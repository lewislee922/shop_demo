import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:shop_demo/core/error/failure.dart';
import 'package:shop_demo/features/shop_home/data/datasources/product_remote_data_source.dart';
import 'package:shop_demo/features/shop_home/data/models/product_data.dart';

import 'mock_data.dart';

void main() {
  group("product remote data test", () {
    late ProductRemoteDataSource repository;
    late MockClient mockHttpClient;
    test("should get single product object when success", () async {
      mockHttpClient = MockClient((_) async => http.Response(
          mockProductData, 200,
          headers: {'content-type': 'application/json'}));
      repository = ProductRemoteDataSourceImpl(client: mockHttpClient);
      expect(
          await repository.getProductById(1),
          equals(ProductData.fromJson(
              json.decode(mockProductData) as Map<String, dynamic>)));
    });

    test("should get products when success", () async {
      mockHttpClient = MockClient((_) async => http.Response(
          mockAllProductData, 200,
          headers: {'content-type': 'application/json'}));
      repository = ProductRemoteDataSourceImpl(client: mockHttpClient);
      expect(await repository.getAllProduct(), isA<List<ProductData>>());
    });

    test("should get all product category", () async {
      mockHttpClient = MockClient((_) async => http.Response(
          mockCategoryData, 200,
          headers: {'content-type': 'application/json'}));
      repository = ProductRemoteDataSourceImpl(client: mockHttpClient);
      expect(await repository.getAllCategory(), isA<List<String>>());
    });

    test("should get products when filter certain category", () async {
      mockHttpClient = MockClient((_) async => http.Response(
          mockFiltedProductData, 200,
          headers: {'content-type': 'application/json'}));
      repository = ProductRemoteDataSourceImpl(client: mockHttpClient);
      expect(await repository.getProductsByCategory("jewelery"),
          isA<List<ProductData>>());
    });

    test("should throw failure when no data", () {
      mockHttpClient = MockClient((_) async => http.Response("", 200,
          headers: {'content-type': 'application/json'}));
      repository = ProductRemoteDataSourceImpl(client: mockHttpClient);
      expectLater(repository.getAllCategory(), throwsA(isA<NoDataFailure>()));
      expectLater(repository.getProductById(1), throwsA(isA<NoDataFailure>()));
      expectLater(repository.getProductsByCategory("hqq"),
          throwsA(isA<NoDataFailure>()));
      expectLater(repository.getAllProduct(), throwsA(isA<NoDataFailure>()));
    });

    test("should throw failure when other network status", () {
      mockHttpClient = MockClient((_) async => http.Response("", 401,
          headers: {'content-type': 'application/json'}));
      repository = ProductRemoteDataSourceImpl(client: mockHttpClient);
      expectLater(repository.getAllCategory(), throwsA(isA<NetworkFailure>()));
      expectLater(repository.getProductById(1), throwsA(isA<NetworkFailure>()));
      expectLater(repository.getProductsByCategory("hqq"),
          throwsA(isA<NetworkFailure>()));
      expectLater(repository.getAllProduct(), throwsA(isA<NetworkFailure>()));
    });
  });
}
