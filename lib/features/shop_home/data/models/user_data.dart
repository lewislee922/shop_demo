import 'package:shop_demo/features/shop_home/data/models/address_data.dart';
import 'package:shop_demo/features/shop_home/domain/entities/address.dart';
import 'package:shop_demo/features/shop_home/domain/entities/user.dart';

class UserData extends User {
  const UserData(Name name, String phone, String email, Address address)
      : super(name, phone, email, address);

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      NameData.fromJson(json['name']),
      json['phone'],
      json['email'],
      AddressData.fromJson(json['address']));
}

class NameData extends Name {
  const NameData(String firstName, String lastName)
      : super(firstName, lastName);

  factory NameData.fromJson(Map<String, dynamic> json) =>
      NameData(json['firstname'], json['lastname']);
}
