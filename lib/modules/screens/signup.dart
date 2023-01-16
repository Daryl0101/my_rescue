import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_rescue/modules/screens/TestFirestore.dart';
import 'package:my_rescue/widgets/app_bar.dart';

import '../../firebase_options.dart';
import '../../widgets/loading_bar.dart';
import '../../widgets/text_button.dart';
import '../auth/fireauth.dart';
import '../auth/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

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

  List<String> occupations = ["Army", "Police", "Firefighter", "Volunteer"];
  String selectedItem = "Volunteer";
  List<Widget> pose = <Widget>[Text('Leader'), Text('Member')];
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
      appBar: UpperNavBar(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: myFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
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
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _emailTextController,
                              focusNode: _focusEmail,
                              validator: (value) => Validator.validateEmail(
                                email: value!,
                              ),
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
                              controller: _passwordTextController,
                              focusNode: _focusPassword,
                              validator: (value) => Validator.validatePassword(
                                password: value!,
                              ),
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
                          // Name
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _nameTextController,
                              focusNode: _focusName,
                              validator: (value) => Validator.validateName(
                                name: value!,
                              ),
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: "Name",
                                hintStyle: TextStyle(color: Colors.grey),
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
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _nricTextController,
                              focusNode: _focusNric,
                              validator: (value) =>
                                  Validator.validateNric(nric: value!),
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: "NRIC",
                                hintStyle: TextStyle(color: Colors.grey),
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
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DropdownButtonFormField<String>(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: "Occupation",
                                hintStyle: TextStyle(color: Colors.grey),
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
                            margin: EdgeInsets.symmetric(vertical: 10),
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
                              textStyle: TextStyle(fontSize: 20),
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
                                User? user =
                                    await FireAuth.registerUsingEmailPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text,
                                );

                                final user_data = {
                                  "name": _nameTextController.text,
                                  "occupation": selectedItem,
                                  "isLeader":
                                      _selectedPose[0] == true ? true : false,
                                  "teamcode": null,
                                  "nric": _nricTextController.text,
                                };

                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(user!.uid)
                                    .set(user_data);

                                if (user != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TestFirestore()));
                                }
                                ;
                              }
                              ;
                            },
                          )
                        ],
                      ),
                    ),
                  ),
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
                          overlayColor:
                              MaterialStatePropertyAll(Colors.transparent),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }
            return LoadingBar(
              text: "Hold on, we are connecting the server",
            );
          },
        ),
      ),
    );
  }
}
