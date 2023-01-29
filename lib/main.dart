import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_rescue/config/themes/theme_config.dart';
import 'package:my_rescue/firebase_options.dart';

import 'package:my_rescue/modules/screens/homepage.dart';

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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android
  );
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
