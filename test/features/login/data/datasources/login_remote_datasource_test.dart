import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:shop_demo/core/error/failure.dart';

import 'package:shop_demo/features/login/data/datasources/login_remote_datasource.dart';

void main() {
  late LoginRemoteDataSource dataSource;
  late MockClient mockHttpClient;
  group("user login test", () {
    test("do post and get json header with token", () async {
      final expectedResponse = http.Response(
          json.encode({"token": "eyyoon1ee"}), 200,
          headers: {'content-type': 'application/json'});
      mockHttpClient = MockClient((request) async => expectedResponse);
      dataSource = LoginRemoteDataSourceImpl(client: mockHttpClient);
      final loginResponse = await dataSource.userLogin("", "");
      expect(loginResponse, "eyyoon1ee");
    });

    test("do post and get unauthered error", () {
      final expectedResponse = http.Response(json.encode({"": ""}), 401,
          headers: {'content-type': 'application/json'});
      mockHttpClient = MockClient((_) async => expectedResponse);
      dataSource = LoginRemoteDataSourceImpl(client: mockHttpClient);
      expectLater(
          dataSource.userLogin("", ""), throwsA(isA<AuthorizedFailure>()));
    });

    test("do post and get network error", () {
      final expectedResponse = http.Response(json.encode({"": ""}), 404,
          headers: {'content-type': 'application/json'});
      mockHttpClient = MockClient((_) async => expectedResponse);
      dataSource = LoginRemoteDataSourceImpl(client: mockHttpClient);
      expectLater(dataSource.userLogin("", ""), throwsA(isA<NetworkFailure>()));
    });
  });
}
