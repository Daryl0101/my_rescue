import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_rescue/modules/screens/victim-help-page.dart';
import 'dart:async';

import 'package:my_rescue/widgets/app_bar.dart';

class HelpMap extends StatefulWidget {
  const HelpMap({super.key});
  static const String routeName = "/help-map";

  @override
  State<HelpMap> createState() => _HelpMapState();
}

class _HelpMapState extends State<HelpMap> {
  String? currentAddress;
  Position? currentPosition;

  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(5.4141, 100.3288),
    zoom: 14.4746,
  );

  //Create the list of markers
  List<Marker> _marker = <Marker>[
    Marker(
      markerId: MarkerId('1'),
    ),
  ];

  // * Check if user have enabled location services and permissions
  Future<bool> _handleUserLocationPermission() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Location service not enabled. Please enable in settings")));
      return false;
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Location permissions not enabled."),
        ));
        return false;
      }
    }

    return true;
  }

  // * Helper function to get user location
  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleUserLocationPermission();
    if (!hasPermission) return;

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        currentPosition = position;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UpperNavBar(
        backButtonFunction: BackButton(
          color: Colors.white,
        ),
      ),
      body: Stack(alignment: Alignment.topCenter, children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: SafeArea(
            // on below line creating google maps
            child: GoogleMap(
              // Disable zoom controls
              zoomControlsEnabled: false,
              // Set camera position
              initialCameraPosition: _kGoogle,
              // Set markers on the map
              markers: Set<Marker>.of(_marker),
              // Specify map type.
              mapType: MapType.normal,
              // Compass enabled.
              compassEnabled: true,
              // Specify controller on map complete.
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ),
      ]),
      // on pressing floating action button the camera will take to user current location
      floatingActionButtonLocation:
          (FloatingActionButtonLocation.miniCenterFloat),

      floatingActionButton: Stack(
        children: [
          Positioned(
              left: 30,
              bottom: 20,
              child: FloatingActionButton.extended(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                label: const Text("LOCATE YOURSELF"),
                heroTag: null,
                onPressed: () async {
                  // ? Call the get location function
                  getCurrentPosition();

                  _marker.add(Marker(
                    markerId: const MarkerId("2"),
                    position: LatLng(currentPosition?.latitude ?? 5.4141,
                        currentPosition?.longitude ?? 100.3288),
                    infoWindow: const InfoWindow(
                      title: "You",
                    ),
                  ));

                  // ? specified current users location, if the location is null
                  // ? it will return a default location at George Town
                  CameraPosition cameraPosition = CameraPosition(
                    target: LatLng(currentPosition?.latitude ?? 5.4141,
                        currentPosition?.longitude ?? 100.3288),
                    zoom: 14,
                  );

                  final GoogleMapController controller =
                      await _controller.future;
                  controller.animateCamera(
                      CameraUpdate.newCameraPosition(cameraPosition));
                },
              )),
          Positioned(
              left: 230,
              bottom: 20,
              child: FloatingActionButton.extended(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  label: const Text("CONFIRM"),
                  heroTag: null,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VictimHelpPage(
                                  latitude: currentPosition?.latitude ?? 5.4141,
                                  longitude:
                                      currentPosition?.longitude ?? 100.3288,
                                )));
                  })),
        ],
      ),
    );
  }
}
