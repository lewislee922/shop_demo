import 'package:equatable/equatable.dart';
import 'package:shop_demo/features/shop_home/domain/entities/address.dart';

class User extends Equatable {
  final Name name;
  final String phone;
  final String email;
  final Address address;

  const User(this.name, this.phone, this.email, this.address);

  @override
  List<Object?> get props => [phone, email];
}

class Name extends Equatable {
  final String firstName;
  final String lastName;

  Name(this.firstName, this.lastName);

  @override
  // TODO: implement props
  List<Object?> get props => [null];
}
