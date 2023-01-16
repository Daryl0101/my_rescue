import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';

class TestFirestore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UpperNavBar(),
        body: Column(
          children: [
            Text(FirebaseAuth.instance.currentUser.toString()),
            ElevatedButton(
              onPressed: () {
                final user = {
                  "name": "Hui Wen",
                  "occupation": "Volunteer",
                  "isLeader": false,
                  "teamcode": null,
                };
                FirebaseFirestore.instance.collection("users").add(user).then(
                    (DocumentReference doc) =>
                        print('DocumentSnapshot added with ID: ${doc.id}'));
              },
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc("sMncKDwtXDqWZ88TvBZU")
                    .delete();
              },
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TestFirestore()));
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }
}
