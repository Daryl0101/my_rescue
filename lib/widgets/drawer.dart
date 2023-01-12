import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

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
          ListTile(
            onTap: () {
              // Closes the drawer
              Navigator.pop(context);
            },
            title: Text(
              "Flood Safety Tips",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
              onTap: () {
                // Closes the drawer
                Navigator.pop(context);
              },
              title: Text(
                "Rescue Team",
                style: Theme.of(context).textTheme.titleMedium,
              ))
        ],
      ),
    );
  }
}
