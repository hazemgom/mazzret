import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mozart_flutter_app/features/admin/sql_connection/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/register_screen.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? _center;
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        markers.add(
          Marker(
            markerId: const MarkerId("My Location"),
            position: _center!,
          ),
        );
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTapped(LatLng latLng) {
    setState(() {
      markers.clear(); // Remove previous marker
      markers.add(
        Marker(
          markerId: const MarkerId("New Location"),
          position: latLng,
        ),
      );
    });
  }

  void _onFloatingActionButtonClicked() async {
    if (markers.isNotEmpty) {
      var preferences = await SharedPreferences.getInstance();

      print("Marker position: ${markers.first.position}");
      print("Marker position: ${markers.toList()}");
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placemark = placemarks[0];
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        print(placemark.street);
        if (placemark.street != null) {
          preferences
              .setString(
            'myLocation',
            placemark.street!,
          )
              .then((value) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return RegisterScreen();
                },
              ),
              (route) => false,
            );
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('please select your location'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _center == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center!,
                zoom: 12.0,
              ),
              markers: Set<Marker>.from(markers),
              onTap: _onMapTapped,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: _onFloatingActionButtonClicked,
        child: const Icon(Icons.add_location),
      ),
    );
  }
}
