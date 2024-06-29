import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_rescue/modules/screens/rescuemission.dart';
import 'package:my_rescue/widgets/drawer.dart';
import 'package:my_rescue/widgets/loading_bar.dart';
import 'package:my_rescue/widgets/mission_details_card.dart';

import '../../firebase_options.dart';

class MissionList extends StatefulWidget {
  const MissionList({super.key});
  static const String routeName = "/mission-list";

  @override
  State<MissionList> createState() => _MissionListState();
}

class _MissionListState extends State<MissionList> {
  String selectedItem = "All States";
  List state = [];
  var missionList;

  // Initialize firebase
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return firebaseApp;
  }

  // List of missions
  Stream<QuerySnapshot> getMissionList(String selection) {
    Stream<QuerySnapshot<Map<String, dynamic>>> missions;
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
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "MyRescue",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          onPressed: () => {
            // Uncomment this line when done
            Navigator.of(context).pop(),
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
      ),
      endDrawer: const CustomDrawer(
        userLogIn: true,
        userIsLeader: true,
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
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: ListView(
                    children: [
                      // State dropdown
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
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
                              hintStyle: const TextStyle(color: Colors.grey),
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
                                      Navigator.pushNamed(
                                          context, RescueMission.routeName,
                                          arguments: element);
                                    },
                                  );
                                  return ml;
                                },
                              ).toList();
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                child: Scrollbar(
                                  thumbVisibility: true,
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
                          return const LoadingBar();
                        },
                      ),
                    ],
                  ),
                );
              }
              return const LoadingBar();
            },
          );
        },
      ),
    );
  }
}
