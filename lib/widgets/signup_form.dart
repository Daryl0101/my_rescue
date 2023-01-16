import 'package:flutter/material.dart';
import 'package:my_rescue/widgets/text_button.dart';

class SignUpForm extends StatefulWidget {
  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> occupations = ["Army", "Police", "Firefighter", "Volunteer"];
  String selectedItem = "Volunteer";
  List<Widget> pose = <Widget>[Text('Leader'), Text('Member')];
  final List<bool> _selectedPose = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
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
            // Name
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
            // Age
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
                  hintText: "Age",
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
                borderColor: Theme.of(context).colorScheme.secondary,
                fillColor: Theme.of(context).colorScheme.secondary,
                selectedColor: Colors.white,
                selectedBorderColor: Theme.of(context).colorScheme.secondary,
                color: Theme.of(context).colorScheme.secondary,
                textStyle: TextStyle(fontSize: 20),
                constraints: BoxConstraints(
                    minHeight: 50,
                    minWidth: MediaQuery.of(context).size.width * .43),
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < _selectedPose.length; i++) {
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
              backgroundColor: Theme.of(context).colorScheme.secondary,
              width: MediaQuery.of(context).size.width * 0.5,
            )
          ],
        ),
      ),
    );
  }
}
