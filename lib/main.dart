import 'package:flutter/material.dart';
import 'package:my_rescue/config/themes/theme_config.dart';
import 'package:my_rescue/modules/screens/leader-missiondetails.dart';
import 'package:my_rescue/modules/screens/leader-rescuemission.dart';
import 'package:my_rescue/modules/screens/signup.dart';
import 'package:my_rescue/modules/screens/volunteer-enrollteam.dart';
import 'package:my_rescue/modules/screens/volunteer-homepage.dart';

import 'modules/screens/TestFirestore.dart';
import 'package:my_rescue/modules/screens/homepage.dart';
//import 'package:my_rescue/modules/screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_rescue/firebase_options.dart';

import 'modules/screens/login.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
//import 'package:my_rescue/modules/screens/victim-help-page.dart';
//import 'package:my_rescue/modules/screens/safety-guidelines.dart';
//import 'package:my_rescue/modules/screens/help-map.dart';
//import 'package:my_rescue/modules/screens/help-submmited-page.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(config);
//    //initilization of Firebase app

//   // other Firebase service initialization

//   runApp(MyApp());
// }
//import 'package:my_rescue/modules/screens/victim-help-page.dart';
//import 'package:my_rescue/modules/screens/safety-guidelines.dart';
//import 'package:my_rescue/modules/screens/help-map.dart';
//import 'package:my_rescue/modules/screens/help-submmited-page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
    );
  }
}
