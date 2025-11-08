import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//! lat long model
// class LatLng extends Equatable {
//   final double? lat;
//   final double? long;

//   const LatLng({
//     required this.lat,
//     required this.long,
//   });

//   factory LatLng.fromMap(Map<String, dynamic> map) {
//     return LatLng(
//       lat: map["lat"] != null
//           ? map["lat"] is String
//               ? double.parse(map["lat"])
//               : map["lat"]
//           : null,
//       long: map["long"] != null
//           ? map["long"] is String
//               ? double.parse(map["long"])
//               : map["long"]
//           : null,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       "lat": lat,
//       "long": long,
//     };
//   }

//   LatLng copyWith({
//     double? lat,
//     double? long,
//   }) {
//     return LatLng(
//       lat: lat ?? this.lat,
//       long: long ?? this.long,
//     );
//   }

//   @override
//   List<Object?> get props => [lat, long];
// }

//! address model
class Address extends Equatable {
  final String? country;
  final String? city;
  final String? street;

  const Address({
    this.country,
    this.city,
    this.street,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      country: map['country'],
      city: map['city'],
    );
  }

  Address copyWith({
    String? country,
    String? city,
    String? street,
  }) {
    return Address(
      country: country ?? this.country,
      city: city ?? this.city,
      street: street ?? this.street,
    );
  }

  @override
  List<Object?> get props => [country, city, street];
}

//! location model
class LocationModel extends Equatable {
  final double latitude;
  final double longitude;
  final double accuracy;
  final String? address;

  const LocationModel({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    this.address,
  });

  LatLng toLatLng() => LatLng(latitude, longitude);

  factory LocationModel.fromPosition(Position position) {
    return LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
      accuracy: position.accuracy,
    );
  }

  LocationModel copyWith({
    double? latitude,
    double? longitude,
    double? accuracy,
    String? address,
  }) {
    return LocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [latitude, longitude, accuracy, address];
}
