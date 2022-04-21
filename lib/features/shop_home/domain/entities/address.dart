import 'package:equatable/equatable.dart';
import 'package:shop_demo/features/shop_home/domain/entities/geolocation.dart';

class Address extends Equatable {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final Geolocation geolocation;

  Address(this.city, this.street, this.number, this.zipcode, this.geolocation);

  @override
  List<Object?> get props => [null];
}
