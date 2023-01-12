import 'package:flutter/material.dart';

class MemberListItem extends StatelessWidget {
  MemberListItem({
    super.key,
    required this.name,
    required this.occupation,
    required this.isLeader,
  });

  final String name;
  final String occupation;
  final bool isLeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: isLeader != true
          ? ListTile(
              title: Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.black),
              ),
              subtitle: Text(
                occupation,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.do_not_disturb_on,
                  color: Colors.black,
                ),
                onPressed: () {},
              ))
          : ListTile(
              title: Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.black),
              ),
              subtitle: Text(
                occupation,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
    );
  }
}
