import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_rescue/modules/screens/profile.dart';
import 'package:my_rescue/widgets/list_item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_rescue/widgets/loading_bar.dart';
import 'package:my_rescue/widgets/mission_details_card.dart';
import 'package:my_rescue/widgets/text_button.dart';

class RescueMission extends StatefulWidget {
  const RescueMission({super.key, required this.mission});

  static const String routeName = "/rescue-mission";

  final QueryDocumentSnapshot mission;

  @override
  State<RescueMission> createState() => _RescueMissionState();
}

class _RescueMissionState extends State<RescueMission> {
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
        title: Text(
          "MyRescue",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          onPressed: () => {
            Navigator.of(context).pop(),
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
      body: Stack(children: [
        //Google Map
        GoogleMap(
          onMapCreated: _onMapCreated,
          zoomControlsEnabled: false,
          mapType: MapType.hybrid,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          myLocationEnabled: true,
          rotateGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.mission["location"].latitude,
                widget.mission["location"].longitude),
            zoom: 15.0,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("marker1"),
              position: LatLng(widget.mission["location"].latitude,
                  widget.mission["location"].longitude),
            ),
          },
        ),
        FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var user = snapshot;
                return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("teams")
                        .doc(user.data!['teamCode'].id)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var team = snapshot;
                        return DraggableScrollableSheet(
                          initialChildSize: 0.6,
                          minChildSize: 0.1,
                          maxChildSize: 0.6,
                          snap: true,
                          builder: (context, scrollController) {
                            return Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30)),
                                  color: Colors.white),
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount:
                                    user.data!['isLeader'] == true ? 5 : 4,
                                itemBuilder: (context, index) {
                                  List<Widget> items = [
                                    const Icon(
                                      Icons.maximize,
                                      size: 70,
                                    ),
                                    Text(
                                      widget.mission.id,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      DateFormat.yMMMd('en_US').add_jm().format(
                                          widget.mission["requestDateTime"]
                                              .toDate()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                    ),
                                    Row(
                                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("X-coordinate",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          color: Colors.black,
                                                        )),
                                                Text("Y-coordinate",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          color: Colors.black,
                                                        )),
                                                Text("Total victims",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          color: Colors.black,
                                                        )),
                                                Text("Elder victims",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          color: Colors.black,
                                                        )),
                                                Text("Locality",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          color: Colors.black,
                                                        )),
                                                Text("State",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          color: Colors.black,
                                                        )),
                                              ]),
                                          Column(children: [
                                            Text(":",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )),
                                            Text(":",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )),
                                            Text(":",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )),
                                            Text(":",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )),
                                            Text(":",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )),
                                            Text(":",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    ))
                                          ]),
                                        ]),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                  widget.mission["location"]
                                                      .longitude
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        color: Colors.black,
                                                      )),
                                              Text(
                                                  widget.mission["location"]
                                                      .latitude
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        color: Colors.black,
                                                      )),
                                              Text(
                                                  widget.mission["totalVictims"]
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        color: Colors.black,
                                                      )),
                                              Text(
                                                  widget.mission["elderVictims"]
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        color: Colors.black,
                                                      )),
                                              Text(widget.mission["locality"],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        color: Colors.black,
                                                      ),
                                                  softWrap: false,
                                                  overflow: TextOverflow.fade),
                                              Text(widget.mission["state"],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        color: Colors.black,
                                                      ),
                                                  softWrap: false,
                                                  overflow: TextOverflow.fade),
                                            ]),
                                      ],
                                    ),
                                    team.data!["currentMission"] == null
                                        // Accept Button
                                        ? CustomTextButton(
                                            text: "Accept",
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                            width: 200,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            buttonFunction: () {
                                              // Update "missions" collection
                                              FirebaseFirestore.instance
                                                  .collection("missions")
                                                  .doc(widget.mission.id)
                                                  .update({
                                                "missionStatus": "Ongoing",
                                                "teamInCharge":
                                                    team.data!.reference
                                              });
                                              // Update "teams" collection
                                              FirebaseFirestore.instance
                                                  .collection("teams")
                                                  .doc(team.data!.id)
                                                  .update({
                                                "currentMission":
                                                    widget.mission.reference
                                              });
                                              setState(() {});
                                            },
                                          )
                                        // Complete Button
                                        : CustomTextButton(
                                            text: "Complete",
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                            width: 200,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            buttonFunction: () {},
                                          )
                                  ];
                                  return Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, right: 15, top: 10),
                                      alignment: Alignment.center,
                                      child: items[index]);
                                },
                              ),
                            );
                          },
                        );
                      }
                      return LoadingBar();
                    });
              }
              return LoadingBar();
            }),
      ]),
    );
  }
}
