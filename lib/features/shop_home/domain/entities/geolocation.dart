import 'package:equatable/equatable.dart';

class Geolocation extends Equatable {
  final String lat;
  final String long;

  Geolocation(this.lat, this.long);

  @override
  List<Object?> get props => [null];
}
