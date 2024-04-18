import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInMap extends StatefulWidget {
  final Map data;

  const LocationInMap({Key? key, required this.data}) : super(key: key);

  @override
  State<LocationInMap> createState() => _LocationInMapState();
}

//30°17'32"N 31°44'28"E
class _LocationInMapState extends State<LocationInMap> {
  final Map<String, Marker> markers = {};

  int i = 0;

  launchMap(lat, long) {
    MapsLauncher.launchCoordinates(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    LatLng initialLocation = LatLng(widget.data['lat'], widget.data['lng']);

    List<Map<String, dynamic>> clityList = [
      {
        "address": widget.data['address'],
        "id": "1",
        "image":
            "https://i.pinimg.com/originals/b7/3a/13/b73a132e165978fa07c6abd2879b47a6.png",
        "lat": widget.data['lat'],
        "lng": widget.data['lng'],
        "name": "${widget.data['name']} ${AppLocalizations.of(context)!.makar}",
        "phone": widget.data['phone'],
        "region": "North Africa"
      }
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.data['address'],
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialLocation,
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) async {
              markers.clear();
              setState(() {
                for (int i = 0; i < clityList.length; i++) {
                  print("For Loop");
                  final marker = Marker(
                    markerId: MarkerId(clityList[i]['name']),
                    position: LatLng(clityList[i]['lat'], clityList[i]['lng']),
                    infoWindow: InfoWindow(
                        title: clityList[i]['name'],
                        snippet: clityList[i]['address'],
                        onTap: () {
                          print(
                              "${clityList[i]['lat']}, ${clityList[i]['lng']}");
                        }),
                    onTap: () {
                      print("Clicked on marker");
                    },
                  );
                  print("${clityList[i]['lat']}, ${clityList[i]['lng']}");
                  markers[clityList[i]['name']] = marker;
                }
              });
            },
            markers: {
              Marker(
                markerId: MarkerId('1'),
                position: initialLocation,
                infoWindow: InfoWindow(
                    title: clityList[i]['name'],
                    snippet: clityList[i]['address'],
                    onTap: () {
                      print("${clityList[i]['lat']}, ${clityList[i]['lng']}");
                    }),
              ),
            },
            circles: {
              Circle(
                circleId: CircleId('1'),
                center: initialLocation,
                radius: 400,
                strokeWidth: 2,
                fillColor: AppColors.primaryColor.withOpacity(0.5),
                strokeColor: Colors.black38,
              ),
            },
          ),
          Positioned(
            left: MyCache.getString(key: CacheKeys.lang) == 'ar' ? 0 : 20,
            bottom: 20,
            child: CustomButtonWidget(
              borderRadius: 10.r,
              width: 220.w,
              height: 49.h,
              color: AppColors.primaryColor,
              text: AppLocalizations.of(context)!.done,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
