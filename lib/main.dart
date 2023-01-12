import 'package:flutter/material.dart';
import 'package:my_rescue/config/themes/theme_config.dart';

import 'modules/screens/homepage.dart';

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
