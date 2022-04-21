import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:shop_demo/core/error/failure.dart';
import 'package:shop_demo/features/shop_home/data/datasources/user_remote_data_source.dart';
import 'package:shop_demo/features/shop_home/data/models/user_data.dart';

import 'mock_data.dart';

void main() {
  late UserRemoteDataSource userRemoteDataSource;
  late MockClient client;
  group("single user remote data test", () {
    test("should get user data when success", () async {
      final expectedResponse = http.Response(mockUserData, 200,
          headers: {'content-type': 'application/json'});
      client = MockClient((_) async => expectedResponse);
      userRemoteDataSource = UserRemoteDataSourceImpl(client: client);
      final result = await userRemoteDataSource.getSingleUserData(1);
      final expected = UserData.fromJson(json.decode(mockUserData));
      expect(result, expected);
    });

    test("should throw no data failure when no user", () {
      final expectedResponse = http.Response(json.encode(null), 200,
          headers: {'content-type': 'application/json'});
      client = MockClient((request) async => expectedResponse);
      userRemoteDataSource = UserRemoteDataSourceImpl(client: client);

      expectLater(userRemoteDataSource.getSingleUserData(0),
          throwsA(isA<NoDataFailure>()));
    });

    test("should throw network failure when network has troble", () {
      final expectedResponse = http.Response(json.encode({"": ""}), 401,
          headers: {'content-type': 'application/json'});
      client = MockClient((_) async => expectedResponse);
      userRemoteDataSource = UserRemoteDataSourceImpl(client: client);
      expectLater(userRemoteDataSource.getSingleUserData(1),
          throwsA(isA<AuthorizedFailure>()));
    });
  });
}
