import 'package:flutter/material.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Theme.of(context).colorScheme.primary,
      ),
      height: 220,
      alignment: Alignment.center,
      child: Text("Weather forecast widget",
          style: Theme.of(context).textTheme.displaySmall),
    );
  }
}
