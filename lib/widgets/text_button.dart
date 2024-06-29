import 'package:flutter/material.dart';
import 'package:my_rescue/config/themes/theme_config.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      this.height = 50,
      this.width = double.infinity,
      this.icon,
      required this.text,
      required this.textStyle,
      this.backgroundColor = myRescueBlue,
      this.buttonSplashColor = myRescueBeige,
      this.textAlign = TextAlign.center,
      this.buttonFunction});

  final double height, width;
  final String text;
  final TextStyle? textStyle;
  final Icon? icon;
  final Color? backgroundColor, buttonSplashColor;
  final TextAlign? textAlign;
  final void Function()? buttonFunction;

  @override
  Widget build(BuildContext context) {
    // Container to decide the background color
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(20)),
      // Sized box to define the size of the button
      child: SizedBox(
        height: height,
        width: width,
        // Stack the Material design on top of the button
        child: Stack(
          children: <Widget>[
            // Row of the icon and text
            Row(
              children: <Widget>[
                (() {
                  if (icon == null) {
                    return Container();
                  }
                  return Container(
                    width: height,
                    height: height,
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: icon,
                    ),
                  );
                }()),
                Expanded(
                  child: Text(
                    text,
                    textAlign: textAlign,
                    style: textStyle,
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
                onTap: buttonFunction,
                borderRadius: BorderRadius.circular(20),
                splashColor: buttonSplashColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
