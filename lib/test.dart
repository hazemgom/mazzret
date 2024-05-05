import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/register_screen.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneNumberController;
  final TextEditingController codeController;
  final TextEditingController zipCodeController;
  final TextEditingController cityController;
  final TextEditingController countryController;
  final TextEditingController streetNameController;
  final TextEditingController apartmentController;
  final TextEditingController floorNumberController;
  final TextEditingController locationController;

  const MapScreen({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneNumberController,
    required this.codeController,
    required this.zipCodeController,
    required this.cityController,
    required this.countryController,
    required this.streetNameController,
    required this.apartmentController,
    required this.floorNumberController,
    required this.locationController,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? _center;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle the case when the user denies location permission
        print('Location permission denied.');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        _markers.add(
          Marker(
            markerId: const MarkerId("My Location"),
            position: _center!,
          ),
        );
      });
    } catch (e) {
      // Handle errors
      print("Error getting location: $e");
      // You can choose to show an error message to the user or retry getting the location
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _search() async {
    String query = _searchController.text;

    List<Location> locations = await locationFromAddress(query);

    if (locations.isNotEmpty) {
      print('***************************');
      Location searchedLocation = locations.first;
      LatLng position =
          LatLng(searchedLocation.latitude, searchedLocation.longitude);
      print(position);
      _updateMarker(position);
    } else {
      // Handle case where no location is found for the given query
    }
  }

  void _onMapTapped(LatLng latLng) {
    _updateMarker(latLng);
  }

  void _updateMarker(LatLng position) {
    setState(() {
      _markers.clear(); // Clear existing markers
      _markers.add(
        Marker(
          markerId: MarkerId('searched_location'),
          position: position,
        ),
      );
    });
    mapController!.animateCamera(
        CameraUpdate.newLatLng(position)); // Move camera to new position
  }

  void _onFloatingActionButtonClicked() async {
    if (_markers.isNotEmpty) {
      print("Marker position: ${_markers.first.position}");
      print("Marker position: ${_markers.toList()}");
      LatLng position = _markers.first.position;
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placemark = placemarks[0];
      setState(
        () {
          _center = LatLng(position.latitude, position.longitude);
          print(placemark.street);
          if (placemark.street != null) {
            widget.locationController.text = placemark.street!;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return RegisterScreen(
                    nameController: widget.nameController,
                    emailController: widget.emailController,
                    passwordController: widget.passwordController,
                    phoneNumberController: widget.phoneNumberController,
                    codeController: widget.codeController,
                    zipCodeController: widget.zipCodeController,
                    cityController: widget.cityController,
                    position: position,
                    countryController: widget.countryController,
                    streetNameController: widget.streetNameController,
                    apartmentController: widget.apartmentController,
                    floorNumberController: widget.floorNumberController,
                    locationController: widget.locationController,
                  );
                },
              ),
              (route) => false,
            );
          }
        },
      );
    }
  }

  String _searchQuery = '';

  Set<Marker> _markers = {};
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Please select your location'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _center == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: _center!,
                    zoom: 12.0,
                  ),
                  markers: _markers,
                  onTap: _onMapTapped,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _searchController,
                          onFieldSubmitted: (value) {
                            _search();
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            hintText: 'Search',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed:
                                  _searchQuery.isNotEmpty ? _search : null,
                            ),
                            border: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          onChanged: (query) {
                            setState(() {
                              _searchQuery = query;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        mini: true,
                        onPressed: () {
                          _initLocation();
                          setState(() {
                            _markers.clear(); // Clear existing markers
                          });
                          mapController!.moveCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: _center!,
                                zoom: 14.0,
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
