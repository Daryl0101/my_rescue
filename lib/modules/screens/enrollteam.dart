import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_rescue/config/themes/theme_config.dart';
import 'package:my_rescue/widgets/text_button.dart';

import '../../widgets/list_item.dart';
import '../auth/validator.dart';

class EnrollTeam extends StatefulWidget {
  const EnrollTeam({super.key, required this.user});

  final DocumentSnapshot user;
  static const String routeName = "/enroll-team";

  @override
  State<EnrollTeam> createState() => _EnrollTeamState();
}

class _EnrollTeamState extends State<EnrollTeam> {
  final double paddingBetweenCol = 20.0;

  final _formKey = GlobalKey<FormState>();
  final _teamCodeController = TextEditingController();
  late bool canJoin;
  var errorMsg = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Row(
          children: [
            Text(
              "MyRescue",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                "MEMBER",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => {
            Navigator.of(context).pop(),
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Theme.of(context).colorScheme.secondary,
        ),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        backgroundColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.95),
        width: MediaQuery.of(context).size.width / 2,
        child: ListView(
          // Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            ListItem(
              text: "Rescue Team",
              specificAction: () => {},
            ),
            ListItem(
              text: "Flood Safety Tips",
              specificAction: () => {},
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: paddingBetweenCol,
                ),
                child: Text(
                  "Enroll yourself",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: paddingBetweenCol / 2,
                ),
                child: SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: _teamCodeController,
                    validator: (value) =>
                        Validator.validateTeamCode(teamCode: value!),
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: myRescueBlue),
                    textAlign: TextAlign.center,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: errorMsg,
                      hintText: "Team Code",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[400],
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: paddingBetweenCol,
                ),
                child: Text("Get the team code from your leader"),
              ),
              CustomTextButton(
                text: "SUBMIT",
                textStyle: Theme.of(context).textTheme.titleMedium,
                width: 300,
                buttonFunction: () {
                  if (_formKey.currentState!.validate()) {
                    var checking = FirebaseFirestore.instance
                        .collection("teams")
                        .doc(_teamCodeController.text)
                        .get()
                        .then((event) {
                      canJoin = event.exists;
                    });
                    checking.whenComplete(() {
                      if (canJoin == true) {
                        // Add user into "teams" collection
                        FirebaseFirestore.instance
                            .collection("teams")
                            .doc(_teamCodeController.text)
                            .update({
                          "members":
                              FieldValue.arrayUnion([widget.user.reference])
                        });

                        // Add team into "users" collection
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(widget.user.id)
                            .update({
                          "teamCode": FirebaseFirestore.instance
                              .collection("teams")
                              .doc(_teamCodeController.text)
                        });

                        // Go back to profile page
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          errorMsg = 'Team does not exist';
                        });
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
