import 'package:flutter/material.dart';

class UpperNavBar extends StatelessWidget implements PreferredSizeWidget {
  const UpperNavBar({
    super.key,
    this.backButtonFunction
  });

  final Widget? backButtonFunction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backButtonFunction,
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
