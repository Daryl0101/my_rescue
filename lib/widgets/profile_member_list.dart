import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_rescue/widgets/list_item.dart';
import 'package:my_rescue/widgets/loading_bar.dart';
import 'package:my_rescue/widgets/member_list_item.dart';

import '../firebase_options.dart';

class ProfileMemberList extends StatefulWidget {
  const ProfileMemberList({super.key});

  @override
  State<ProfileMemberList> createState() => _ProfileMemberListState();
}

class _ProfileMemberListState extends State<ProfileMemberList> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return firebaseApp;
  }

  Future<DocumentSnapshot> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  late DocumentSnapshot user;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.only(bottom: 10),
        child: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            return FutureBuilder(
              future: getUserDetails().then((value) => user = value),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return LoadingBar();
                  case ConnectionState.none:
                    return Text("Nothing");
                  case ConnectionState.active:
                  case ConnectionState.done:
                    return (StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .where("teamCode", isEqualTo: user["teamCode"])
                          .orderBy('isLeader', descending: true)
                          .orderBy('name')
                          .snapshots(),
                      // This is a QuerySnapshot
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var memberList = snapshot.data!.docs.map((element) {
                            // Remove current user from the list
                            Widget memberList = element.id == user.id
                                ? Container()
                                : MemberListItem(
                                    isLeader: user["isLeader"],
                                    element: element,
                                  );

                            return memberList;
                          }).toList();
                          return memberList.length <= 1
                              ? const Center(
                                  child: Text("No member"),
                                )
                              : Scrollbar(
                                  isAlwaysShown: true,
                                  child: ListView(
                                    children: memberList,
                                  ),
                                );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ));
                }
              },
            );
          },
        ));
  }
}
