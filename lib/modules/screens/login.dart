import 'package:flutter/material.dart';
import 'package:my_rescue/widgets/app_bar.dart';
import 'package:my_rescue/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Change the navbar later
      appBar: UpperNavBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account?'),
              TextButton(
                onPressed: () => {},
                child: Text(
                  "SIGN UP",
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
    );
  }
}
