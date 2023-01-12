import 'package:flutter/material.dart';
import 'package:my_rescue/widgets/list_item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_rescue/widgets/member_list_item.dart';
import 'package:my_rescue/widgets/mission_details_card.dart';
import 'package:my_rescue/widgets/text_button.dart';
import 'package:intl/intl.dart';

class LeaderMissionDetails extends StatefulWidget {
  const LeaderMissionDetails({super.key});

  @override
  State<LeaderMissionDetails> createState() => _LeaderMissionDetailsState();
}

class _LeaderMissionDetailsState extends State<LeaderMissionDetails> {
  // Rescue mission data (Dummy)
  String id = "#PEN00001";
  LatLng center = const LatLng(5.354878200450183, 100.30152659634784);
  DateTime requestDateTime = DateTime.now().toLocal();
  int totalVictims = 10;
  int elderVictims = 2;
  String area = "Gelugor";

  // Team data (Dummy)
  String teamCode = "#A10001";
  String name1 = "Ritchie Poh";
  String name2 = "Daryl Tneoh";
  String name3 = "Lee Kuan Fu";
  String name4 = "Neo Ming Ann";
  String name5 = "Ling Shao Doo";
  String occupation1 = "Army";
  String occupation2 = "Firefighter";
  String occupation3 = "Police";
  String occupation4 = "Volunteer";
  String occupation5 = "Volunteer";

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
            Container(
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
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              // Rescue mission title
              Text(
                "Rescue Mission",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black),
              ),
              // Mission details
              MissionDetailsCard(
                id: id,
                center: center,
                requestDateTime: requestDateTime,
                totalVictims: totalVictims,
                elderVictims: elderVictims,
                area: area,
              ),
            ]),
            Column(children: [
              // Team code
              Text(
                "Team Code\t:\t\t" + teamCode,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black),
              ),
              // Team code description
              const Text("Share the code to your group members"),
            ]),
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.only(bottom: 10),
              child: Scrollbar(
                isAlwaysShown: true,
                child: ListView(
                  children: [
                    MemberListItem(
                      name: name1,
                      occupation: occupation1,
                      isLeader: true,
                    ),
                    MemberListItem(
                      name: name2,
                      occupation: occupation2,
                      isLeader: false,
                    ),
                    MemberListItem(
                      name: name3,
                      occupation: occupation3,
                      isLeader: false,
                    ),
                    MemberListItem(
                      name: name4,
                      occupation: occupation4,
                      isLeader: false,
                    ),
                    MemberListItem(
                      name: name5,
                      occupation: occupation5,
                      isLeader: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
