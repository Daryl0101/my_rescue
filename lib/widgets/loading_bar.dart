import 'package:flutter/material.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({super.key, this.text = "Loading"});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
