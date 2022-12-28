import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.height = 50,
    required this.text
  });

  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    // Container to decide the background color
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20)),
      // Sized box to define the size of the button
      child: SizedBox(
        height: height,

        // Stack the Material design on top of the button
        child: Stack(
          children: <Widget>[
            // Row of the icon and text
            Row(
              children: <Widget>[
                Container(
                  width: height,
                  height: height,
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Icon(
                      Icons.map_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                )
              ],
            ),
            /* 
            Material design above the row to enable the clean and nice splash effect
            */
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                splashColor: Theme.of(context).colorScheme.background,
              ),
            )
          ],
        ),
      ),
    );
  }
}
