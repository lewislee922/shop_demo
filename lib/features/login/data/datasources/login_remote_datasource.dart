import 'dart:convert';

import 'package:http/http.dart';
import 'package:shop_demo/core/error/failure.dart';

abstract class LoginRemoteDataSource {
  Future<String> userLogin(String username, String password);
  Future<bool> userLogout();
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Client client;
  LoginRemoteDataSourceImpl({required this.client});
  @override
  Future<String> userLogin(String name, String password) async {
    final _response = await client.post(
      Uri.parse("https://fakestoreapi.com/auth/login"),
      body: {"username": name, "password": password},
    );
    switch (_response.statusCode) {
      case 200:
        return json.decode(_response.body)['token'];
      case 401:
        throw AuthorizedFailure();
      default:
        throw NetworkFailure();
    }
  }

  @override
  Future<bool> userLogout() async {
    return true;
  }
}
