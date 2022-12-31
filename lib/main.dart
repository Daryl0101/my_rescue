import 'package:flutter/material.dart';
import 'package:my_rescue/config/themes/theme_config.dart';
import 'package:my_rescue/modules/screens/volunteer-enrollteam.dart';
import 'package:my_rescue/modules/screens/volunteer-homepage.dart';

import 'package:my_rescue/modules/screens/homepage.dart';
//import 'package:my_rescue/modules/screens/homepage.dart';
//import 'package:my_rescue/modules/screens/victim-help-page.dart';
//import 'package:my_rescue/modules/screens/safety-guidelines.dart';
//import 'package:my_rescue/modules/screens/help-map.dart';
//import 'package:my_rescue/modules/screens/help-submmited-page.dart';

void main() {
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
