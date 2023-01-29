import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_rescue/modules/screens/enrollteam.dart';
import 'package:my_rescue/widgets/list_item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_rescue/widgets/member_list_item.dart';
import 'package:my_rescue/widgets/mission_details_card.dart';
import 'package:my_rescue/widgets/profile_member_list.dart';
import 'package:my_rescue/widgets/text_button.dart';
import 'package:intl/intl.dart';

import '../../firebase_options.dart';
import '../../widgets/loading_bar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  static const String routeName = "/profile";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return firebaseApp;
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

            // Either deal with user "isLeader" checking, or delete this segment
            // This part shows the user status (leader/member) in the app bar
            // Container(
            //   margin: EdgeInsets.only(left: 10),
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 10,
            //   ),
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     color: Theme.of(context).colorScheme.secondary,
            //   ),
            //   child: Text(
            //     "LEADER",
            //     style: Theme.of(context).textTheme.titleSmall,
            //   ),
            // ),
          ],
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
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final user = snapshot.data;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            // Profile title
                            Text(
                              "Profile",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.black),
                            ),
                            // User Profile
                            Card(
                              margin: EdgeInsets.only(top: 10),
                              color: Colors.white,
                              elevation: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .8,
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        FirebaseAuth.instance.currentUser!.email
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Colors.black,
                                            )),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Name",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )),
                                            Text("NRIC",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )),
                                            Text("Occupation",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )),
                                            Text("Status",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
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
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              user!["name"],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Text(user["nric"],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )),
                                            Text(user["occupation"],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )),
                                            Text(
                                                user["isLeader"] == true
                                                    ? "Leader"
                                                    : "Member",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        user["teamCode"] == null
                            // Prompt user without team to enroll
                            ? Column(children: [
                                Text(
                                  "You are not in any team.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                TextButton(
                                    onPressed: () {
                                      // Navigate to Enrollment Page
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            EnrollTeam(user: user),
                                      ));
                                    },
                                    child: Text(
                                      "Enroll Now",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.bold),
                                    ))
                              ])
                            : Column(children: [
                                // Team code
                                Text(
                                  "Current Team\t:\t\t" + user["teamCode"].id,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(color: Colors.black),
                                ),
                                // Team code description
                                user["isLeader"] != true
                                    ? Container()
                                    : const Text(
                                        "Share the code to your group members"),
                              ]),
                        // Members List
                        user["teamCode"] == null
                            ? Container()
                            : ProfileMemberList(),
                        // Leave Team Button
                        user["teamCode"] == null || user["isLeader"] == true
                            ? Container()
                            : CustomTextButton(
                                icon: Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                text: "Leave Team",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                                backgroundColor: Colors.red,
                                width: MediaQuery.of(context).size.width * .6,
                                buttonFunction: () {
                                  // Remove user from "teams" collection
                                  FirebaseFirestore.instance
                                      .collection("teams")
                                      .doc(user["teamCode"].id)
                                      .update({
                                    "members":
                                        FieldValue.arrayRemove([user.reference])
                                  });

                                  // Remove team from "users" collection
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(user.id)
                                      .update({"teamCode": null});

                                  setState(() {});
                                },
                              ),
                      ],
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          }
          return Center(
            child: LoadingBar(
              text: "Hold on, we are connecting the server",
            ),
          );
        },
      ),
    );
  }
}
