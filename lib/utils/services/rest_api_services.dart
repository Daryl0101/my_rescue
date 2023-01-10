import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_rescue/constants/api_path.dart';

Future<Weather> fetchWeatherAPI() async {
  final response = await http.get(Uri.parse(openMeteoWeatherAPI));

  // If the response is OK
  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load the weather API.");
  }
}

class Weather {
  final double latitude;
  final double longitude;
  final List<dynamic> dates;
  final List<dynamic> weatherCode;

  const Weather(
      {required this.latitude,
      required this.longitude,
      required this.dates,
      required this.weatherCode});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        latitude: json['latitude'],
        longitude: json['longitude'],
        dates: json['daily']['time'],
        weatherCode: json['daily']['weathercode']);
  }
}
