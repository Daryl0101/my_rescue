import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_rescue/modules/screens/victim-help-page.dart';
import 'dart:async';

class HelpMap extends StatefulWidget {
  const HelpMap({super.key});

  @override
  State<HelpMap> createState() => _HelpMapState();
}

class _HelpMapState extends State<HelpMap> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(5.4141, 100.3288),
    zoom: 14.4746,
  );

  //Create the list of markers
  final List<Marker> _marker = <Marker>[
    Marker(
      markerId: MarkerId('1'),
    ),
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MyRescue",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
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
                  getUserCurrentLocation().then((value) async {
                    print(value.latitude.toString() +
                        " " +
                        value.longitude.toString());

                    // marker added for current users location
                    _marker.add(Marker(
                      markerId: MarkerId("2"),
                      position: LatLng(value.latitude, value.longitude),
                      infoWindow: InfoWindow(
                        title: "You",
                      ),
                    ));

                    // specified current users location
                    CameraPosition cameraPosition = new CameraPosition(
                      target: LatLng(value.latitude, value.longitude),
                      zoom: 14,
                    );

                    final GoogleMapController controller =
                        await _controller.future;
                    controller.animateCamera(
                        CameraUpdate.newCameraPosition(cameraPosition));
                    setState(() {});
                  });
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
                            builder: (context) => const VictimHelpPage()));
                  })),
        ],
      ),
    );
  }
}
