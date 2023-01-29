import 'package:flutter/material.dart';
import 'package:my_rescue/modules/screens/profile.dart';
import 'package:my_rescue/widgets/list_item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_rescue/widgets/mission_details_card.dart';
import 'package:my_rescue/widgets/text_button.dart';

class LeaderRescueMission extends StatefulWidget {
  const LeaderRescueMission({super.key});
  static const String routeName = "/leader-rescue-mission";

  @override
  State<LeaderRescueMission> createState() => _LeaderRescueMissionState();
}

class _LeaderRescueMissionState extends State<LeaderRescueMission> {
  // Rescue mission data (Dummy)
  String id = "#PEN00001";
  LatLng center = const LatLng(5.354878200450183, 100.30152659634784);
  DateTime requestDateTime = DateTime.now().toLocal();
  int totalVictims = 10;
  int elderVictims = 2;
  String area = "Gelugor";

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Row(
          children: [
            Text(
              "MyRescue",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                "LEADER",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => {
            // Uncomment this line when done
            // Navigator.of(context).pop(),
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Theme.of(context).colorScheme.secondary,
        ),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        backgroundColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.95),
        width: MediaQuery.of(context).size.width / 2,
        child: ListView(
          // Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            ListItem(
              text: "Rescue Team",
              specificAction: () => {},
            ),
            ListItem(
              text: "Flood Safety Tips",
              specificAction: () => {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Container holds the Google Map showing victim's location
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              mapType: MapType.hybrid,
              tiltGesturesEnabled: true,
              compassEnabled: true,
              myLocationEnabled: true,
              rotateGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("marker1"),
                  position: center,
                ),
              },
            ),
          ),
          // Mission details
          MissionDetailsCard(
            id: id,
            center: center,
            requestDateTime: requestDateTime,
            totalVictims: totalVictims,
            elderVictims: elderVictims,
            area: area,
          ),
          // Accept Button
          CustomTextButton(
            text: "Accept",
            textStyle: Theme.of(context).textTheme.titleMedium,
            width: 200,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            buttonFunction: acceptButtonFunction,
          )
        ],
      ),
    );
  }

  void acceptButtonFunction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
  }
}
