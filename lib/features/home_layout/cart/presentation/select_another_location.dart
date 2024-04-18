import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/presentation/screens/admin_edit_user.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/managers/user_cart_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/previous_adress.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/navigation.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart'
    hide Location, Polyline;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class MapToSelectAnotherLocation extends StatefulWidget {
  Map<String, dynamic> map;

  MapToSelectAnotherLocation({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  State<MapToSelectAnotherLocation> createState() =>
      _MapToSelectAnotherLocationState();
}

class _MapToSelectAnotherLocationState
    extends State<MapToSelectAnotherLocation> {
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  final Set<Marker> _markers = {};
  LatLng? _selectedLocation;
  String _currentAddress = '';
  LatLng? _currentLocation;
  final Set<Polyline> _polylines = {};
  Polyline? _routeLine;

  @override
  void dispose() {
    _mapController?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _getCurrentLocation();
  }

  Future<void> _searchPlace(String searchTerm) async {
    try {
      List<Location> locations =
          await GeocodingPlatform.instance.locationFromAddress(searchTerm);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        List<Placemark> placemarks =
            await GeocodingPlatform.instance.placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          LatLng destination = LatLng(location.latitude, location.longitude);
          _drawRoute(_currentLocation!, destination);

          _mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: destination,
                zoom: 15.0,
              ),
            ),
          );
          setState(() {
            _selectedLocation = destination;
            _currentAddress = placemark.street! +
                placemark.locality! +
                ', ' +
                placemark.administrativeArea! +
                ', ' +
                placemark.country!;
            _markers.clear();
            _markers.add(
              Marker(
                markerId: const MarkerId('selectedLocation'),
                position: _selectedLocation!,
                infoWindow: InfoWindow(
                    title: AppLocalizations.of(context)!.selectedLocation),
              ),
            );
            _drawRoute(_currentLocation!, destination);
          });
        }
      } else {
        setState(() {
          _selectedLocation = null;
          _currentAddress = 'No location found';
          _markers.clear();
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _drawRoute(LatLng origin, LatLng destination) {
    setState(() {
      _polylines.clear();
      _routeLine = Polyline(
        polylineId: const PolylineId('routeLine'),
        color: Colors.blue,
        width: 4,
        points: [origin, destination],
      );
      _polylines.add(_routeLine!);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _getCurrentLocation();
      _selectedLocation = null;
      _currentAddress = '';
      _markers.clear();
      _polylines.clear();
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (widget.map['lat'].runtimeType == String) {
        _currentLocation = LatLng(
            double.parse(widget.map['lat']), double.parse(widget.map['lng']));
      } else {
        _currentLocation = LatLng(widget.map['lat'], widget.map['lng']);
      }
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _currentLocation!,
            zoom: 15.0,
          ),
        ),
      );

      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: _currentLocation!,
            infoWindow: InfoWindow(
                title: AppLocalizations.of(context)!.currentLocation),
          ),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.chooseBranchLocation,
          style: AppFonts.titleScreen,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomTextFormFiled(
            label:
            AppLocalizations.of(context)!.searchForSelectTheBranchLocation,
            suffixIcon: IconButton(
              onPressed: _clearSearch,
              icon: const Icon(
                Icons.close,
              ),
            ),
            preffixIcon: IconButton(
              onPressed: () {
                String searchTerm = _searchController.text;
                _searchPlace(searchTerm);
              },
              icon: Icon(Icons.search, size: 28.sp),
            ),
            hintText:
            AppLocalizations.of(context)!.searchForSelectTheBranchLocation,
            controller: _searchController,
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 15.0,
                  ),
                  polylines: _polylines,
                  markers: _markers,
                ),
                Positioned(
                  top: 16.0,
                  right: 16.0,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.primaryColor,
                    onPressed: _getCurrentLocation,
                    child: Icon(
                      Icons.my_location,
                      color: AppColors.white,
                    ),
                  ),
                ),
                _selectedLocation == null
                    ? Container()
                    : Positioned(
                  left: MyCache.getString(key: CacheKeys.lang) == 'ar'
                      ? 0
                      : 20,
                  bottom: 20,
                  child: CustomButtonWidget(
                    borderRadius: 10.r,
                    width: 220.w,
                    height: 49.h,
                    color: AppColors.primaryColor,
                    text: AppLocalizations.of(context)!.done,
                    onPressed: () {
                      Map<String, dynamic> map = {
                        // 'userId': widget.map['userId'],
                        'lat': _selectedLocation!.latitude.toString(),
                        'lng': _selectedLocation!.longitude.toString(),
                        'address': _currentAddress,
                      };
                      UserCartCubit.get(context).newPosition = _currentAddress ;
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        FadePageRoute(
                          builder: (context) => PreviousAdress(
                            address: _currentAddress,
                          ),
                        ),
                      );
                      // Navigator.pushReplacementNamed(context, RouteName.addNewUser);
                    },
                  ),
                ),
              ],
            ),
          ),
          _selectedLocation == null
              ? Container()
              : Container(
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.lat} & ${AppLocalizations.of(context)!.lng}: ',
                      style: GoogleFonts.cairo(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${_selectedLocation?.latitude ?? ''}, ${_selectedLocation?.longitude ?? ''}',
                      style: GoogleFonts.cairo(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.address}: ',
                      style: GoogleFonts.cairo(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _currentAddress,
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
