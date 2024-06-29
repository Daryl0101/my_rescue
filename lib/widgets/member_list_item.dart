import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MemberListItem extends StatelessWidget {
  MemberListItem({super.key, required this.element, required this.isLeader});

  final QueryDocumentSnapshot element;
  final bool isLeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: isLeader == true
          ? ListTile(
              title: Text(
                element["name"],
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.black),
              ),
              subtitle: Text(
                element["occupation"],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                onPressed: () {
                  // Remove user from "teams" collection
                  FirebaseFirestore.instance
                      .collection("teams")
                      .doc(element["teamCode"].id)
                      .update({
                    "members": FieldValue.arrayRemove([element.reference])
                  });
                  // Remove team from "users" collection
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(element.id)
                      .update({"teamCode": null});
                },
              ))
          : ListTile(
              title: Row(
                children: [
                  Text(
                    element["name"],
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.black),
                  ),
                  element["isLeader"] != true
                      ? Container()
                      : Container(
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
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                ],
              ),
              subtitle: Text(
                element["occupation"],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
    );
  }
}
