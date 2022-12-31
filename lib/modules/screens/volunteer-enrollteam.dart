import 'package:flutter/material.dart';
import 'package:my_rescue/widgets/text_button.dart';

import '../../widgets/list_item.dart';

class VolunteerEnrollTeam extends StatefulWidget {
  const VolunteerEnrollTeam({super.key});

  @override
  State<VolunteerEnrollTeam> createState() => _VolunteerEnrollTeamState();
}

class _VolunteerEnrollTeamState extends State<VolunteerEnrollTeam> {
  final double paddingBetweenCol = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          "MyRescue",
          style: Theme.of(context).textTheme.titleLarge,
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
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: paddingBetweenCol,
              ),
              child: Text(
                "Enrolll yourself",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: paddingBetweenCol,
              ),
              child: SizedBox(
                width: 200,
                child: TextField(
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Team Code",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[400],
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: paddingBetweenCol,
              ),
              child: Text("Get the team code from your leader"),
            ),
            Padding(
                padding: EdgeInsets.only(
                  bottom: paddingBetweenCol,
                ),
                child: CustomTextButton(text: "SUBMIT")),
          ],
        ),
      ),
    );
  }
}
