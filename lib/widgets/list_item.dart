import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.text,
    required this.specificAction,
  });

  final String text;
  final GestureTapCallback specificAction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        textAlign: TextAlign.right,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      onTap: specificAction,
    );
  }
}
