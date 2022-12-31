import 'package:flutter/material.dart';
import 'package:my_rescue/modules/screens/volunteer-enrollteam.dart';
import 'package:my_rescue/widgets/drawer.dart';
import 'package:my_rescue/widgets/list_item.dart';

import '../../widgets/text_button.dart';
import '../../widgets/weather_forecast.dart';

class VolunteerHomePage extends StatefulWidget {
  const VolunteerHomePage({super.key});

  @override
  State<VolunteerHomePage> createState() => _VolunteerHomePageState();
}

class _VolunteerHomePageState extends State<VolunteerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MyRescue",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          WeatherForecast(),
          CustomTextButton(
            height: 70,
            text: "Safe Places",
            textStyle: Theme.of(context).textTheme.titleLarge,
          )
        ],
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
              specificAction: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VolunteerEnrollTeam()));
              },
            ),
            ListItem(
              text: "Flood Safety Tips",
              specificAction: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
