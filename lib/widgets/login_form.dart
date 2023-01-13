import 'package:flutter/material.dart';
import 'package:my_rescue/widgets/text_button.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Login form title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "LOGIN",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.black),
              ),
            ),
            // Email
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            // Password
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            // Login Button
            CustomTextButton(
              text: "LOGIN",
              textStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              width: MediaQuery.of(context).size.width * 0.5,
            )
          ],
        ),
      ),
    );
  }
}
