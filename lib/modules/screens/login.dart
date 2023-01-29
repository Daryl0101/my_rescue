import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_rescue/config/themes/theme_config.dart';
import 'package:my_rescue/modules/screens/signup.dart';
import 'package:my_rescue/widgets/app_bar.dart';

import '../../firebase_options.dart';
import '../../widgets/loading_bar.dart';
import '../../widgets/text_button.dart';
import '../auth/fireauth.dart';
import '../auth/validator.dart';
import 'profile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  var errorMsg;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Change the navbar later
      appBar: const UpperNavBar(),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
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
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: _emailTextController,
                            focusNode: _focusEmail,
                            validator: (value) =>
                                Validator.validateEmail(email: value!),
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: "Email",
                              hintStyle: const TextStyle(color: Colors.grey),
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
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: _passwordTextController,
                            focusNode: _focusPassword,
                            validator: (value) =>
                                Validator.validatePassword(password: value!),
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              errorText: errorMsg,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: "Password",
                              hintStyle: const TextStyle(color: Colors.grey),
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
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          width: MediaQuery.of(context).size.width * 0.5,
                          // buttonFunction: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               LeaderMissionDetails()));
                          // },
                          buttonFunction: () async {
                            if (_formKey.currentState!.validate()) {
                              var user = await FireAuth.loginUsingEmailPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text,
                                context: context,
                              );

                              if (user.runtimeType == FirebaseAuthException) {
                                if (user.code == 'user-not-found') {
                                  errorMsg = 'No user found for that email.';
                                } else if (user.code == 'wrong-password') {
                                  errorMsg = 'Wrong password provided.';
                                }
                                setState(() {});
                              } else {
                                if (user != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Profile()));
                                }
                              }

                              // if (user != null) {
                              //   Navigator.of(context)
                              //       .pushReplacement(
                              //     MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
                              //   );
                              // }
                            }
                          },
                        ),

                        RichText(
                            text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(color: myRescueBlue),
                                children: <TextSpan>[
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                  text: "Sign up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(color: myRescueOrange),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).popAndPushNamed(
                                          SignUpPage.routeName);
                                    })
                            ]))
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: LoadingBar(
              text: "Hold on, we are connecting the server",
            ),
          );
        },
      ),
    );
  }
}
