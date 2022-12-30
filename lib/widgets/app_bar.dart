import 'package:flutter/material.dart';

class UpperNavBar extends StatelessWidget implements PreferredSizeWidget {
  const UpperNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      //actionsIconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        "MyRescue",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
