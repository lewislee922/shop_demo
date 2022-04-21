import 'package:shop_demo/features/shop_home/data/datasources/user_remote_data_source.dart';

import '../entities/user.dart';

abstract class UserDataRepository {
  Future<User> fetchUserData(int id);
}

class UserDataRepositoryImpl implements UserDataRepository {
  final UserRemoteDataSource dataSource;
  UserDataRepositoryImpl(this.dataSource);

  @override
  Future<User> fetchUserData(int id) async {
    try {
      final _user = await dataSource.getSingleUserData(id);
      return _user;
    } catch (e) {
      rethrow;
    }
  }
}
