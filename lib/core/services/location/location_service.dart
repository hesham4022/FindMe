import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/resources/strings.dart';

class LocationService {
  double? lat;
  double? lng;
  Position? currentPosition;

  //! Get user location coordinates
  Future<Either<Failure, Position>> getUserLocationCoordinates() async {
    try {
      final failure = await handleLocationPermission();

      if (failure != null) {
        return Left(failure);
      }
      final position = await Geolocator.getCurrentPosition();
      log(position.toString());
      currentPosition = position;
      lat = position.latitude;
      lng = position.longitude;

      return Right(position);
    } catch (e) {
      log(e.toString());
      return Left(LocationDetectionFailure(e.toString()));
    }
  }

  //! Get user location coordinates
  Future<Either<Failure, Stream<Position>>>
      getUserLocationCoordinatesStream() async {
    final failure = await handleLocationPermission();

    if (failure != null) {
      return Left(failure);
    }

    return Right(Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    ));
  }

  //! Handle location permission
  Future<Failure?> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // 1. Check if service is enabled
    if (!serviceEnabled) {
      return const LocationDetectionFailure(AppStrings.locationServiceDisabled);
    }
    // 2. Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const LocationDetectionFailure(AppStrings.locationPermsDenied);
      }
    }
    // 3. Check if location permission is denied permanently
    if (permission == LocationPermission.deniedForever) {
      return const LocationDetectionFailure(
          AppStrings.locationPermsPermanentlyDenied);
    }

    return null;
  }

//------------------------------------------------------------------------------
  // Future<List<Placemark>> getAddressFromCoordinates(LatLong coordinates) async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(
  //     coordinates.lat!,
  //     coordinates.long!,
  //   );
  //   return placemarks;
  // }

  Future<String> getAddress(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    final address = "${placemarks[0].street}, ${placemarks[0].locality}";
    log("address: $address");
    return address;
  }

//   Future<List<Location>> _getCoordinatesFromAddress(Address address) async {
//     List<Location> locations = await locationFromAddress(
//       "${address.city}, ${address.country}",
//     );
//     return locations;
//   }

  // Future<Either<Failure, LocationModel>> getUserLocation() async {
  //   // if (_cachedUserLocation != null) {
  //   //   debugPrint("CACHED LOCATION: ${_cachedUserLocation.toString()}");
  //   //   return Right(_cachedUserLocation!);
  //   // }

  //   //1.
  //   final result = await getUserLocationCoordinates();
  //   //2.
  //   return result.fold(
  //     (failure) => Left(failure),
  //     (position) async {
  //       final latLong = LatLong.fromPosition(position);
  //       final placemarks = await getAddressFromCoordinates(latLong);

  //       if (placemarks.isEmpty) {
  //         return const Left(Failure(AppStrings.unexpectedErrorTitle));
  //       }

  //       final location = LocationModel(
  //         latLong: latLong,
  //         address: Address(
  //           country: placemarks[0].country,
  //           city: placemarks[0].locality,
  //           street: placemarks[0].street,
  //         ),
  //       );

  //       // _cachedUserLocation = location;
  //       return Right(location);
  //     },
  //   );
  // }

  //! Get user location coordinates
  Stream<ServiceStatus> getLocationServiceStatus() {
    return Geolocator.getServiceStatusStream();
  }
}
