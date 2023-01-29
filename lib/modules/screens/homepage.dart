import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_rescue/config/themes/theme_config.dart';
import 'package:my_rescue/modules/screens/help-map.dart';
import 'package:my_rescue/modules/screens/login.dart';
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
  bool showHelpButton = false, showSignInButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UpperNavBar(),
      endDrawer: const CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const WeatherForecast(),

          // * Button that directs to safety guidelines page
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
              Navigator.of(context).pushNamed(SafetyGuidelinesPage.routeName);
            },
          ),

          (() {
            if (FirebaseAuth.instance.currentUser == null) {
              return CustomTextButton(
                  text: "Sign Up/Sign In",
                  textStyle: Theme.of(context).textTheme.titleMedium,
                  buttonFunction: () => Navigator.of(context).pushNamed(LoginPage.routeName),
              );
            }
            return Container();
          }()),

          // * Show the HELP button based on logic
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
          }()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myRescueBeige,
        splashColor: myRescueBeige,
        elevation: 0,
        onPressed: () => setState(() {
          showHelpButton = !showHelpButton;
        }),
      ),
    );
  }
}
