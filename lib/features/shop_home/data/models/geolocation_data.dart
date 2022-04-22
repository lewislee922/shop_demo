import 'package:shop_demo/features/shop_home/domain/entities/geolocation.dart';

class GeolocationData extends Geolocation {
  const GeolocationData(String lat, String long) : super(lat, long);

  factory GeolocationData.fromJson(Map<String, dynamic> json) =>
      GeolocationData(json['lat'], json['long']);
}
