import 'package:flutter/material.dart';
import 'package:my_rescue/config/themes/theme_config.dart';
import 'package:my_rescue/widgets/app_bar.dart';
import 'package:my_rescue/widgets/bullet.dart';

class SafetyGuidelinesPage extends StatefulWidget {
  const SafetyGuidelinesPage({super.key});

  @override
  State<SafetyGuidelinesPage> createState() => _SafetyGuidelinesPageState();
}

class _SafetyGuidelinesPageState extends State<SafetyGuidelinesPage>
    with TickerProviderStateMixin {
  bool visible_before = true;
  bool visible_current = false;
  bool visible_after = false;

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UpperNavBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Theme.of(context).colorScheme.background,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Text("Flood Safety Tips: What To Do",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black)
                      .copyWith(fontSize: 20)),
            ),
            Flexible(
              flex: 1,
              child: TabBar(controller: _controller, tabs: const [
                Tab(
                  text: "Before",
                ),
                Tab(
                  text: "During",
                ),
                Tab(
                  text: "After",
                )
              ],
              indicatorColor: myRescueOrange,
              isScrollable: true,
              labelStyle: Theme.of(context).textTheme.titleMedium,
              labelColor: myRescueBlue,
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TabBarView(
                  controller: _controller,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: BulletList(const [
                        'Prepare an escape route out of the flood and away from floodwaters',
                        'Keep the copies of critical documents in a waterproof container',
                        'Prepare an emergency supply kit containing:',
                        'Non-perishable food, Drinking water, First aid supplies, Essential Medicines, Flashlight, Clothes and Blankets, Rain gear, Cash'
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: BulletList(const [
                        'Evacuate immediately if told to do so',
                        'Move immediately to higher ground or stay on high ground',
                        'Follow recommended evacuation routes/plans',
                        'Continue to check the media for emergency information',
                        'Stay away from power lines and electrical wires',
                        'Do not walk through flowing water. Use a pole or stick to aid your movements in the water.',
                        'Do not drive through flooded area or around road with barriers',
                        'If your vehicle is trapped in rapidly moving water, try to stay in your vehicle. If water is uprising rapidly, seek refuge on the car roof.',
                        'Look out for animals especially wild animals that are hostile towards us.'
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: BulletList(const [
                        'Do not return home and follow instructions from the public safety officials',
                        'Listen to the latest announcements from the radio and TV',
                        'Inspect electric circuits, gas and water sources before turning them back on or consuming it',
                        'Inspect septic tank',
                        'Remove all flood affected foods and beverages',
                        'Remove wet and soggy items and dry them throughly',
                        'Clean and disinfect everything submerged in floodwater',
                        'Make a detailed list of all damaged or lost properties with photos to file a flood claim from insurance company'
                      ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
