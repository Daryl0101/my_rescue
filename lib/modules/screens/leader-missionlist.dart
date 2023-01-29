import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_rescue/modules/screens/rescuemission.dart';
import 'package:my_rescue/widgets/list_item.dart';
import 'package:my_rescue/widgets/loading_bar.dart';
import 'package:my_rescue/widgets/mission_details_card.dart';

import '../../firebase_options.dart';

class MissionList extends StatefulWidget {
  const MissionList({super.key});

  @override
  State<MissionList> createState() => _MissionListState();
}

class _MissionListState extends State<MissionList> {
  String selectedItem = "All States";
  List state = [];
  var missionList = null;

  // Initialize firebase
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return firebaseApp;
  }

  // List of missions
  Stream<QuerySnapshot> getMissionList(String selection) {
    var missions = null;
    if (selection == "All States") {
      missions = FirebaseFirestore.instance
          .collection("missions")
          .where("missionStatus", isEqualTo: "Pending")
          .orderBy("requestDateTime", descending: false)
          .snapshots();
    } else {
      missions = FirebaseFirestore.instance
          .collection("missions")
          .where("missionStatus", isEqualTo: "Pending")
          .where("state", isEqualTo: selection)
          .orderBy("requestDateTime", descending: false)
          .snapshots();
    }
    return missions;
  }

  // List of states
  Stream getStateList() {
    var states = FirebaseFirestore.instance
        .collection("uniqueItems")
        .doc("stateList")
        .snapshots();
    return states;
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
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.symmetric(
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
      body: FutureBuilder(
        // Initialize firebase
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          // Get list of states
          return StreamBuilder(
            stream: getStateList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                state = snapshot.data["states"];
                var currentStates = state + ["All States"];
                currentStates.sort();
                return Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Column(
                    children: [
                      // State dropdown
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: selectedItem,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis),
                            dropdownColor: Colors.white,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: "State",
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: currentStates
                                .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                    )))
                                .toList(),
                            onChanged: (item) {
                              setState(
                                () => selectedItem = item.toString(),
                              );
                            }),
                      ),
                      // Get list of missions from firestore
                      StreamBuilder(
                        stream: getMissionList(selectedItem),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.size > 0) {
                              missionList = snapshot.data!.docs.map(
                                (element) {
                                  var ml = MissionDetailsCard(
                                    mission: element,
                                    specificAction: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RescueMission(
                                                mission: element)),
                                      );
                                    },
                                  );
                                  return ml;
                                },
                              ).toList();
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                child: Scrollbar(
                                  isAlwaysShown: true,
                                  child: ListView(
                                    children: missionList,
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text(
                                "No Mission",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.black),
                              ));
                            }
                          }
                          return LoadingBar();
                        },
                      ),
                    ],
                  ),
                );
              }
              return LoadingBar();
            },
          );
        },
      ),
    );
  }
}
