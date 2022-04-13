import 'dart:convert';

import 'package:http/http.dart';

abstract class LoginRemoteDataSource {
  Future<String?> userLogin(String name, String password);
  Future<bool> userLogout();
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Client client;
  LoginRemoteDataSourceImpl({required this.client});
  @override
  Future<String?> userLogin(String name, String password) async {
    final _response = await client.post(
        Uri.parse("https://fakestoreapi.com/auth/login"),
        headers: {"username": name, "password": password});
    if (_response.statusCode == 200) {
      return json.decode(_response.body)['token'];
    } else {
      throw Error();
    }
  }

  @override
  Future<bool> userLogout() {
    // TODO: implement userLogout
    throw UnimplementedError();
  }
}
