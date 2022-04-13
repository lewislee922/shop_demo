import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:shop_demo/features/login/data/datasources/login_remote_datasource.dart';

class MockUri extends Mock implements Uri {}

void main() {
  late LoginRemoteDataSource dataSource;
  late MockClient mockHttpClient;
  group("remote datasource test", () {
    test("perform post login response and get json header with token",
        () async {
      final expectedResponse = http.Response(
          json.encode({"token": "eyyoon1ee"}), 200,
          headers: {'content-type': 'application/json'});
      mockHttpClient = MockClient((request) async {
        return expectedResponse;
      });
      dataSource = LoginRemoteDataSourceImpl(client: mockHttpClient);
      final loginResponse = await dataSource.userLogin("", "");
      expect(loginResponse, "eyyoon1ee");
    });

    test("login failure", () async {
      final expectedResponse = http.Response(
          json.encode({"": ""}), 404,
          headers: {'content-type': 'application/json'});
    });

    test("network error", () async {});
  });
}
