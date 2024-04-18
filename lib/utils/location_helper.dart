// import 'package:geolocator/geolocator.dart';
// Position? position;
// Future<Position> determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.error('Location services are disabled.');
//   }
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }
//   if (permission == LocationPermission.deniedForever) {
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }
//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   await Geolocator.getCurrentPosition().then((value) {
//     position = value;
//   });
//   return await Geolocator.getCurrentPosition();
// }

/*--------------------------*/
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// String? address;
// Position? position;
//
// Future<Position> determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;
//
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     throw Exception('Location services are disabled.');
//   }
//
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       throw Exception('Location permissions are denied');
//     }
//   }
//
//   if (permission == LocationPermission.deniedForever) {
//     throw Exception('Location permissions are permanently denied, we cannot request permissions.');
//   }
//
//   Position currentPosition = await Geolocator.getCurrentPosition().then((value) {
//    return position = value;
//   });
//
//   List<Placemark> placemarks = await placemarkFromCoordinates(
//     currentPosition.latitude,
//     currentPosition.longitude,
//   );
//
//   Placemark currentPlacemark = placemarks.first;
//   address = currentPlacemark.thoroughfare! + ', ' + currentPlacemark.locality!;
//
//   return currentPosition;
// }
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

String? address;
Position? position;

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Location permissions are permanently denied, we cannot request permissions.');
  }

  Position currentPosition = await Geolocator.getCurrentPosition();
  position = currentPosition;

  List<Placemark> placemarks = await placemarkFromCoordinates(
    currentPosition.latitude,
    currentPosition.longitude,
  );

  Placemark currentPlacemark = placemarks.first;
  String street = currentPlacemark.thoroughfare ?? "";
  String city = currentPlacemark.locality ?? "";

  address = '$street, $city';

  return currentPosition;
}