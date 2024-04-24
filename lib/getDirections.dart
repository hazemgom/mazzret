// import 'dart:convert';
//
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
//
// Future<List<LatLng>> getDirections(LatLng origin, LatLng destination) async {
//   const apiKey = 'AIzaSyAmueQeHbpoFL6Aa7jULAUw8F02YicXhi8'; // Replace with your Google Maps API key
//   final url =
//       'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';
//
//
//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     final json = jsonDecode(response.body);
//     final routes = json['routes'] as List<dynamic>;
//     if (routes.isNotEmpty) {
//       final legs = routes.first['legs'] as List<dynamic>;
//       if (legs.isNotEmpty) {
//         final steps = legs.first['steps'] as List<dynamic>;
//         final polylinePoints = <LatLng>[];
//         for (final step in steps) {
//           final points = step['polyline']['points'] as String;
//           final decodedPoints = _decodePolyline(points);
//           polylinePoints.addAll(decodedPoints);
//         }
//         return polylinePoints;
//       }
//     }
//   }
//   return [];
// }
//
// List<LatLng> _decodePolyline(String encodedPolyline) {
//   final List<LatLng> polylinePoints = [];
//   int index = 0;
//   int lat = 0;
//   int lng = 0;
//
//   while (index < encodedPolyline.length) {
//     int shift = 0;
//     int result = 0;
//     int byte;
//
//     do {
//       byte = encodedPolyline.codeUnitAt(index++) - 63;
//       result |= (byte & 0x1F) << shift;
//       shift += 5;
//     } while (byte >= 0x20);
//
//     int deltaLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//     lat += deltaLat;
//
//     shift = 0;
//     result = 0;
//
//     do {
//       byte = encodedPolyline.codeUnitAt(index++) - 63;
//       result |= (byte & 0x1F) << shift;
//       shift += 5;
//     } while (byte >= 0x20);
//
//     int deltaLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//     lng += deltaLng;
//
//     double latDouble = lat / 1E5;
//     double lngDouble = lng / 1E5;
//
//     final point = LatLng(latDouble, lngDouble);
//     polylinePoints.add(point);
//   }
//
//   return polylinePoints;
// }