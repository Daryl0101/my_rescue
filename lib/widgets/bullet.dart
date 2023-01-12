import 'package:flutter/material.dart';

class BulletList extends StatelessWidget {
  final List<String> strings;

  BulletList(this.strings);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\u2022',
                style: TextStyle(
                  fontSize: 20,
                  height: 1,
                  color: Color.fromARGB(255, 255, 255, 255).withOpacity(1),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    str,
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: Color.fromARGB(255, 255, 255, 255))
                        .copyWith(fontSize: 14),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
