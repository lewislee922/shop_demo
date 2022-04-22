part of 'shop_home_bloc.dart';

abstract class ShopHomeEvent extends Equatable {
  const ShopHomeEvent();

  @override
  List<Object> get props => [];
}

class FetchProductEvent extends ShopHomeEvent {
  final Map<String, dynamic> parameters;

  const FetchProductEvent(this.parameters);
}
