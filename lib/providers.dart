import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:shop_demo/features/login/data/datasources/login_remote_datasource.dart';
import 'package:shop_demo/features/login/data/repositories/user_login_repository_impl.dart';
import 'package:shop_demo/features/login/domain/repositories/user_login_repository.dart';
import 'package:shop_demo/features/login/domain/usecases/user_login.dart';
import 'package:shop_demo/features/login/presentation/bloc/login_bloc.dart';
import 'package:shop_demo/features/shop_home/data/datasources/product_remote_data_source.dart';
import 'package:shop_demo/features/shop_home/data/datasources/user_remote_data_source.dart';
import 'package:shop_demo/features/shop_home/data/repositories/product_data_repository_impl.dart';
import 'package:shop_demo/features/shop_home/domain/repositories/user_data_repository.dart';
import 'package:shop_demo/features/shop_home/presentation/bloc/product_bloc/shop_home_bloc.dart';

final client = Provider((ref) => Client());
final userRemoteDataSource =
    Provider((ref) => UserRemoteDataSourceImpl(client: ref.watch(client)));
final productRemoteDataSource =
    Provider((ref) => ProductRemoteDataSourceImpl(client: ref.watch(client)));
final loginRemoteDataSource =
    Provider((ref) => LoginRemoteDataSourceImpl(client: ref.watch(client)));
final productDataRepository = Provider(
    (ref) => ProductDataRepositoryImpl(ref.watch(productRemoteDataSource)));
final userDataRepository =
    Provider((ref) => UserDataRepositoryImpl(ref.watch(userRemoteDataSource)));
final userLoginRepository = Provider(
    (ref) => UserLoginRepositoryImpl(ref.watch(loginRemoteDataSource)));
final loginBloc =
    Provider((ref) => LoginBloc(UserLogin(ref.watch(userLoginRepository))));
final productBloc = Provider((ref) => ShopHomeBloc(
    ref.watch(userDataRepository), ref.watch(productDataRepository)));
