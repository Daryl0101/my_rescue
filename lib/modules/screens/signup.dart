import 'package:flutter/material.dart';
import 'package:my_rescue/widgets/app_bar.dart';
import 'package:my_rescue/widgets/login_form.dart';

import '../../widgets/signup_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Change the navbar later
      appBar: UpperNavBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignUpForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                  onPressed: () => {},
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
