import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_rescue/config/themes/theme_config.dart';
import 'package:my_rescue/widgets/app_bar.dart';

class Signout extends StatefulWidget {
  const Signout({super.key});
  static const String routeName = "/signout";

  @override
  State<Signout> createState() => _SignoutState();
}

class _SignoutState extends State<Signout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UpperNavBar(
        backButtonFunction: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/", ModalRoute.withName("/"));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "Successfully signed out!",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: myRescueBlue),
        ),
      ),
    );
  }
}
