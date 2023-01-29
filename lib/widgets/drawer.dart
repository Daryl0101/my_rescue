import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../modules/screens/profile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.userLogIn});

  final bool userLogIn;

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
                  // Closes the drawer
                  Navigator.pushNamed(context, Profile.routeName).then((value) => Navigator.pop(context));
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
          ListTile(
              onTap: () {
                // Closes the drawer
                Navigator.pop(context);
              },
              title: Text(
                "Rescue Team",
                style: Theme.of(context).textTheme.titleMedium,
              )),
          // ListTile(
          //   onTap: () {
          //     FirebaseAuth.instance.signOut();
          //     Navigator.pop(context, true);
          //   },
          //   title: Text(
          //     "Sign out",
          //     style: Theme.of(context).textTheme.titleMedium,
          //   ),
          // )
        ],
      ),
    );
  }
}
