import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_rescue/modules/screens/TestFirestore.dart';
import 'package:my_rescue/widgets/app_bar.dart';

import '../../config/themes/theme_config.dart';
import '../../firebase_options.dart';
import '../../widgets/loading_bar.dart';
import '../../widgets/text_button.dart';
import '../auth/fireauth.dart';
import '../auth/validator.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String routeName = "/signup";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _nricTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusName = FocusNode();
  final _focusNric = FocusNode();

  var errorMsg;

  List<String> occupations = ["Army", "Police", "Firefighter", "Volunteer"];
  String selectedItem = "Volunteer";
  List<Widget> pose = <Widget>[const Text('Leader'), const Text('Member')];
  final List<bool> _selectedPose = <bool>[true, false];

  late Future myFuture;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return firebaseApp;
  }

  @override
  void initState() {
    myFuture = _initializeFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Change the navbar later
      appBar: const UpperNavBar(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: myFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Sign in form title
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "SIGN UP",
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
                              validator: (value) => Validator.validateEmail(
                                email: value!,
                              ),
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
                              validator: (value) => Validator.validatePassword(
                                password: value!,
                              ),
                              style: const TextStyle(fontSize: 20),
                              decoration: InputDecoration(
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
                          // Name
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _nameTextController,
                              focusNode: _focusName,
                              validator: (value) => Validator.validateName(
                                name: value!,
                              ),
                              style: const TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: "Name",
                                hintStyle: const TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              autocorrect: false,
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          // NRIC
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _nricTextController,
                              focusNode: _focusNric,
                              validator: (value) =>
                                  Validator.validateNric(nric: value!),
                              style: const TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: "NRIC",
                                hintStyle: const TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          // Occupation
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: DropdownButtonFormField<String>(
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                errorText: errorMsg,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: "Occupation",
                                hintStyle: const TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items: occupations
                                  .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                      )))
                                  .toList(),
                              onChanged: (item) => setState(
                                () => selectedItem = item.toString(),
                              ),
                            ),
                          ),
                          // Toggle Button
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ToggleButtons(
                              borderRadius: BorderRadius.circular(10),
                              borderColor:
                                  Theme.of(context).colorScheme.secondary,
                              fillColor:
                                  Theme.of(context).colorScheme.secondary,
                              selectedColor: Colors.white,
                              selectedBorderColor:
                                  Theme.of(context).colorScheme.secondary,
                              color: Theme.of(context).colorScheme.secondary,
                              textStyle: const TextStyle(fontSize: 20),
                              constraints: BoxConstraints(
                                  minHeight: 50,
                                  minWidth:
                                      MediaQuery.of(context).size.width * .43),
                              onPressed: (int index) {
                                setState(() {
                                  // The button that is tapped is set to true, and the others to false.
                                  for (int i = 0;
                                      i < _selectedPose.length;
                                      i++) {
                                    _selectedPose[i] = i == index;
                                  }
                                });
                              },
                              isSelected: _selectedPose,
                              children: pose,
                            ),
                          ),

                          // Sign Up Button
                          CustomTextButton(
                            text: "SIGN UP",
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            width: MediaQuery.of(context).size.width * 0.5,
                            buttonFunction: () async {
                              if (_formKey.currentState!.validate()) {
                                // Check if Volunteers register as Leader
                                if (selectedItem == "Volunteer" &&
                                    _selectedPose[0] == true) {
                                  errorMsg =
                                      'Volunteer cannot register as Leader';
                                  setState(() {});
                                } else {
                                  var user =
                                      await FireAuth.registerUsingEmailPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text,
                                  );
                                  // Check for errors when signing up
                                  if (user.runtimeType ==
                                      FirebaseAuthException) {
                                    if (user.code == 'weak-password') {
                                      errorMsg =
                                          'The password provided is too weak.';
                                    } else if (user.code ==
                                        'email-already-in-use') {
                                      errorMsg =
                                          'The account already exists for that email.';
                                    }
                                    setState(() {});
                                  } else {
                                    var count = await FirebaseFirestore.instance
                                        .collection('teams')
                                        .get()
                                        .then(
                                            (value) => value.size + 1 + 100000);
                                    final teamId = "A$count";
                                    final userData = {
                                      "name": _nameTextController.text,
                                      "occupation": selectedItem,
                                      "isLeader": _selectedPose[0] == true
                                          ? true
                                          : false,
                                      "teamCode": _selectedPose[0] == true
                                          ? FirebaseFirestore.instance
                                              .collection("teams")
                                              .doc(teamId)
                                          : null,
                                      "nric": _nricTextController.text,
                                    };

                                    // Create user profile in "users" collection
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(user!.uid)
                                        .set(userData);

                                    // If user is Leader, create new team in "teams" collection
                                    if (_selectedPose[0] == true) {
                                      FirebaseFirestore.instance
                                          .collection("teams")
                                          .doc(teamId)
                                          .set({
                                        "leader": FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user!.uid),
                                        "members": []
                                      });
                                    }

                                    if (user != null && mounted) {
                                      Navigator.of(context).pop(false);
                                    }
                                  }
                                }
                              }
                            },
                          ),                                                                         
                        ],
                      ),
                    ),
                  ),
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: myRescueBlue),
                          children: <TextSpan>[
                        const TextSpan(text: "Already have an account? "),
                        TextSpan(
                            text: "Sign in",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(color: myRescueOrange),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .popAndPushNamed(LoginPage.routeName);
                              })
                      ]))
                ],
              );
            }
            return const LoadingBar(
              text: "Hold on, we are connecting the server",
            );
          },
        ),
      ),
    );
  }
}
