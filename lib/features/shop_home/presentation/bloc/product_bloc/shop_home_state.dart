part of 'shop_home_bloc.dart';

abstract class ShopHomeState extends Equatable {
  const ShopHomeState();

  @override
  List<Object> get props => [];
}

class ShopHomeInitial extends ShopHomeState {}

class ShopHomeLoading extends ShopHomeState {}

class ShopHomeFinish extends ShopHomeState {
  final Map<String, dynamic> data;
  const ShopHomeFinish(this.data);
}
