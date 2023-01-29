import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_rescue/config/themes/theme_config.dart';
import 'package:my_rescue/modules/screens/help-submmited-page.dart';
import 'package:my_rescue/widgets/app_bar.dart';
import 'package:my_rescue/widgets/text_button.dart';
import 'package:geocoding/geocoding.dart' as geocoder;

class VictimHelpPage extends StatefulWidget {
  const VictimHelpPage(
      {super.key, required this.latitude, required this.longitude});

  final double latitude, longitude;
  static const String routeName = "/help-submission";

  @override
  State<VictimHelpPage> createState() => _VictimHelpPage();
}

class _VictimHelpPage extends State<VictimHelpPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  // ? A Map where it defines all the attributes of a document
  // ? It also defines the default values if the data is not specified when uploading to Firestore
  var mission = <String, dynamic>{
    "completeDateTime": null,
    "elderVictims": 0,
    "locality": "",
    "location": null,
    "missionStatus": "Pending",
    "requestDateTime": null,
    "state": null,
    "teamInCharge": null,
    "totalVictims": 1
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UpperNavBar(
        backButtonFunction: BackButton(
          color: Colors.white,
        ),
      ),
      // ? This is to avoid pixel overflow when keyboard appears
      resizeToAvoidBottomInset: false,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  height: 280,
                  alignment: Alignment.center,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.latitude, widget.longitude),
                      zoom: 14.4746,
                    ),
                  )),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Total Victims :",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(color: Colors.black)),
                            SizedBox(height: 50),
                            Text("Victims > 60 Y/O : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: myRescueBlue),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
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
                              onSubmitted: (value) => setState(() {
                                mission["totalVictims"] = int.parse(value);
                              }),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: myRescueBlue),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
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
                              onSubmitted: (value) => setState(() {
                                mission["elderVictims"] = int.parse(value);
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 70),
                child: CustomTextButton(
                  text: "SUBMIT",
                  textStyle: Theme.of(context).textTheme.displaySmall,
                  buttonFunction: () async {
                    await setLocation(widget.latitude, widget.longitude);
                    mission["requestDateTime"] = DateTime.now();
                    db.collection("missions").add(mission);
                    // Check if the state is still mounted or not
                    if (!mounted) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HelpSubmittedPage(
                                  latitude: widget.latitude,
                                  longitude: widget.longitude,
                                )));
                  },
                ),
              ),
            ],
          )),
    );
  }

  setLocation(latitude, longitude) async {
    var addresses =
        await geocoder.placemarkFromCoordinates(latitude, longitude);
    setState(() {
      mission["location"] = GeoPoint(latitude, longitude);
      mission["locality"] = addresses[0].locality.toString();
      mission["state"] = addresses[0].administrativeArea.toString();
    });
  }
}
