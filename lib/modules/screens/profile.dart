import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_rescue/modules/screens/enrollteam.dart';
import 'package:my_rescue/widgets/app_bar.dart';
import 'package:my_rescue/widgets/drawer.dart';
import 'package:my_rescue/widgets/profile_member_list.dart';
import 'package:my_rescue/widgets/text_button.dart';

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
      appBar: const UpperNavBar(),
      endDrawer: const CustomDrawer(
        userLogIn: false,
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
                    margin: const EdgeInsets.symmetric(vertical: 25),
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
                              margin: const EdgeInsets.only(top: 10),
                              color: Colors.white,
                              elevation: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .8,
                                padding: const EdgeInsets.all(15),
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
                                        const Spacer(),
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
                                        const Spacer(),
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
                            : const ProfileMemberList(),
                        // Leave Team Button
                        user["teamCode"] == null || user["isLeader"] == true
                            ? Container()
                            : CustomTextButton(
                                icon: const Icon(
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
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          }
          return const Center(
            child: LoadingBar(
              text: "Hold on, we are connecting the server",
            ),
          );
        },
      ),
    );
  }
}
