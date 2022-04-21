part of 'shop_home_bloc.dart';

abstract class ShopHomeEvent extends Equatable {
  const ShopHomeEvent();

  @override
  List<Object> get props => [];
}

class fetchProductEvent extends ShopHomeEvent {
  final Map<String, dynamic> parameters;

  const fetchProductEvent(this.parameters);
}
