import 'package:shop_demo/features/shop_home/data/models/geolocation_data.dart';
import 'package:shop_demo/features/shop_home/domain/entities/address.dart';
import 'package:shop_demo/features/shop_home/domain/entities/geolocation.dart';

class AddressData extends Address {
  const AddressData(String city, String street, int number, String zipcode,
      Geolocation geolocation)
      : super(city, street, number, zipcode, geolocation);

  factory AddressData.fromJson(Map<String, dynamic> json) => AddressData(
      json['city'],
      json['street'],
      json['number'],
      json['zipcode'],
      GeolocationData.fromJson(json['geolocation']));
}
