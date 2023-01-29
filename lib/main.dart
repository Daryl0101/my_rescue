import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_rescue/config/themes/theme_config.dart';
import 'package:my_rescue/firebase_options.dart';
import 'package:my_rescue/modules/screens/enrollteam.dart';
import 'package:my_rescue/modules/screens/help-map.dart';
import 'package:my_rescue/modules/screens/help-submmited-page.dart';

import 'package:my_rescue/modules/screens/homepage.dart';
import 'package:my_rescue/modules/screens/leader-rescuemission.dart';
import 'package:my_rescue/modules/screens/login.dart';
import 'package:my_rescue/modules/screens/profile.dart';
import 'package:my_rescue/modules/screens/safety-guidelines.dart';
import 'package:my_rescue/modules/screens/signout.dart';
import 'package:my_rescue/modules/screens/signup.dart';
import 'package:my_rescue/modules/screens/victim-help-page.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(config);
//   initilization of Firebase app

//   other Firebase service initialization

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(config);
//    initilization of Firebase app

//    other Firebase service initialization

//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appThemeData,
      home: const SafeArea(child: HomePage()),
      // Disable the debug flag
      debugShowCheckedModeBanner: false,

      // ? The routes parameter are for screens which doesn't require argument
      routes: {
        SafetyGuidelinesPage.routeName: (context) =>
            const SafetyGuidelinesPage(),
        HelpMap.routeName: (context) => const HelpMap(),
        LeaderRescueMission.routeName: (context) => const LeaderRescueMission(),
        LoginPage.routeName: (context) => const LoginPage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        Signout.routeName: (context) => const Signout(),
        Profile.routeName: (context) => const Profile(),
      },

      // ? The onGenerateRoute parameter are for screens whcih require argument
      onGenerateRoute: (settings) {
        switch (settings.name) {
          // * Routes for screeen which require single arguments
          case EnrollTeam.routeName:
            return MaterialPageRoute(
                builder: (context) =>
                    EnrollTeam(user: settings.arguments as DocumentSnapshot));

          // * Routes for screens which requires multiple arguments
          case HelpSubmittedPage.routeName:
            List<dynamic> args = settings.arguments as List<dynamic>;
            return MaterialPageRoute(
                builder: (ctx) =>
                    HelpSubmittedPage(latitude: args[0], longitude: args[1]));

          case VictimHelpPage.routeName:
            List<dynamic> args = settings.arguments as List<dynamic>;
            return MaterialPageRoute(
                builder: (context) =>
                    VictimHelpPage(latitude: args[0], longitude: args[1]));
        }
      },
    );
  }
}
