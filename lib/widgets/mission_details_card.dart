// import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class MissionDetailsCard extends StatefulWidget {
  const MissionDetailsCard({
    super.key,
    required this.mission,
    this.specificAction,
  });

  final DocumentSnapshot mission;
  final GestureTapCallback? specificAction;

  @override
  State<MissionDetailsCard> createState() => _MissionDetailsCardState();
}

class _MissionDetailsCardState extends State<MissionDetailsCard> {
  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      color: Colors.white,
      elevation: widget.specificAction != null ? 3 : 1,
      child: widget.specificAction != null
          // Card is clickable if function provided
          ? InkWell(
              splashColor: Colors.white,
              onTap: widget.specificAction,
              child: Column(children: [
                // Google Map
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  margin: const EdgeInsets.all(10),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(widget.mission["location"].latitude,
                            widget.mission["location"].longitude),
                        zoom: 12),
                    liteModeEnabled: true,
                    mapToolbarEnabled: false,
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId("marker1"),
                        position: LatLng(widget.mission["location"].latitude,
                            widget.mission["location"].longitude),
                      ),
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.mission.id,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
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
                            Text("Location",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.black,
                                    )),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("",
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
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat.yMMMd('en_US').add_jm().format(
                                  widget.mission["requestDateTime"].toDate()),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                            Text(widget.mission["totalVictims"].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.black,
                                    )),
                            Text(widget.mission["elderVictims"].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.black,
                                    )),
                            Text(
                                widget.mission["locality"] +
                                    ', ' +
                                    widget.mission["state"],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                                softWrap: false,
                                overflow: TextOverflow.fade),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            )
          // Card is unclickable if no function provided
          : Column(children: [
              // Google Map
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                margin: const EdgeInsets.all(10),
                child: GoogleMap(
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  mapToolbarEnabled: false,
                  liteModeEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.mission["location"].latitude,
                        widget.mission["location"].longitude),
                    zoom: 4.25,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("marker1"),
                      position: LatLng(widget.mission["location"].latitude,
                          widget.mission["location"].longitude),
                    ),
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.mission.id,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        Text("Total victims",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                    )),
                        Text("Elder victims",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                    )),
                        Text("Location",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                    )),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                    )),
                        Text(":",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                    )),
                        Text(":",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                    )),
                        Text(":",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                    )),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMMMd('en_US').add_jm().format(
                              widget.mission["requestDateTime"].toDate()),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(widget.mission["totalVictims"].toString(),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                    )),
                        Text(widget.mission["elderVictims"].toString(),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                    )),
                        Text(
                            widget.mission["locality"] +
                                ', ' +
                                widget.mission["state"],
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                    ),
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
    );
  }
}
