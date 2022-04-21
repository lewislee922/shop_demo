import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/failure.dart';
import '../models/user_data.dart';

abstract class UserRemoteDataSource {
  Future<UserData> getSingleUserData(int id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserData> getSingleUserData(int id) async {
    final _response =
        await client.get(Uri.parse("https://fakestoreapi.com/users/$id"));
    switch (_response.statusCode) {
      case 200:
        final _json = json.decode(_response.body);
        if (_json != null) {
          final _data = Map<String, dynamic>.from(_json);
          return UserData.fromJson(_data);
        }
        throw NoDataFailure();
      case 401:
        throw AuthorizedFailure();
      default:
        throw NetworkFailure();
    }
  }
}
