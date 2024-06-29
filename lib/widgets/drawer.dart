import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_rescue/modules/screens/leader-missionlist.dart';
import 'package:my_rescue/modules/screens/rescuemission.dart';
import 'package:my_rescue/modules/screens/signout.dart';

import '../modules/screens/profile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.userLogIn, required this.userIsLeader});

  final bool userLogIn, userIsLeader;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Background of drawer is slightly transparent
      backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(230),
      child: ListView(
        children: <Widget>[
          (() {
            if (widget.userLogIn) {
              return ListTile(
                onTap: () {
                  // Pushes the new screen then pops the drawer
                  Navigator.pushNamed(context, Profile.routeName)
                      .then((value) => Navigator.pop(context));
                  // Navigator.pop(context);
                },
                title: Text(
                  "Profile",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }
            return Container();
          }()),

          (() {
            if (widget.userLogIn && widget.userIsLeader) {
              return ListTile(
                onTap: () {
                  // Pushes the new screen then pops the drawer
                  Navigator.pushNamed(context, MissionList.routeName)
                      .then((value) => Navigator.pop(context));
                  // Navigator.pop(context);
                },
                title: Text(
                  "Mission List",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }
            return Container();
          }()),

          // Sign out button based on user authentication
          (() {
            if (widget.userLogIn) {
              return ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  // Pushes the new screen then pops the drawer
                  Navigator.pushNamed(context, Signout.routeName)
                      .then((value) => Navigator.pop(context));
                },
                title: Text(
                  "Sign out",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }
            return Container();
          }())
        ],
      ),
    );
  }
}
