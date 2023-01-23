import 'package:flutter/material.dart';
import 'package:my_rescue/modules/screens/help-map.dart';
import 'package:my_rescue/modules/screens/safety-guidelines.dart';
import 'package:my_rescue/widgets/drawer.dart';
import 'package:my_rescue/widgets/text_button.dart';
import 'package:my_rescue/widgets/weather_forecast.dart';
import 'package:my_rescue/widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showHelpButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UpperNavBar(),
      endDrawer: const CustomDrawer(),
      body: Column(
        children: <Widget>[
          const WeatherForecast(),
          CustomTextButton(
            height: 70,
            text: "Safety Guidelines",
            icon: Icon(
              Icons.bookmark_border_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
            textStyle: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.start,
            buttonFunction: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SafetyGuidelinesPage()));
            },
          ),
          (() {
            if (showHelpButton) {
              return CustomTextButton(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.5,
                text: "HELP!",
                textStyle: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 50),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                buttonSplashColor: Theme.of(context).colorScheme.primary,
                buttonFunction: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HelpMap()));
                },
              );
            } else {
              return Container();
            }
          }())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          showHelpButton = !showHelpButton;
        }),
      ),
    );
  }
}
