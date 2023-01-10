import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

// Map of WMO Weather interpretation codes with weather icons
// https://open-meteo.com/en/docs#latitude=5.37&longitude=100.25&daily=weathercode&timezone=Asia%2FSingapore:~:text=Weather%20variable%20documentation
Map<int, Icon> weatherCodesToIcon = const {
  0 : Icon(WeatherIcons.day_sunny),
  1 : Icon(WeatherIcons.day_cloudy),
  2 : Icon(WeatherIcons.cloudy),
  3 : Icon(WeatherIcons.day_sunny_overcast),
  45 : Icon(WeatherIcons.fog),
  48 : Icon(WeatherIcons.fog),
  51 : Icon(WeatherIcons.day_showers),
  53 : Icon(WeatherIcons.day_showers),
  55 : Icon(WeatherIcons.showers),
  56 : Icon(WeatherIcons.day_sleet),
  57 : Icon(WeatherIcons.sleet),
  61 : Icon(WeatherIcons.rain_mix),
  63 : Icon(WeatherIcons.rain),
  65 : Icon(WeatherIcons.rain_wind),
  66 : Icon(WeatherIcons.rain),
  67 : Icon(WeatherIcons.rain_wind),
  71 : Icon(WeatherIcons.snow),
  73 : Icon(WeatherIcons.snow),
  75 : Icon(WeatherIcons.snow),
  77 : Icon(WeatherIcons.snow),
  80 : Icon(WeatherIcons.showers),
  81 : Icon(WeatherIcons.showers),
  82 : Icon(WeatherIcons.showers),
  85 : Icon(WeatherIcons.day_snow_wind),
  86 : Icon(WeatherIcons.day_snow_wind),
  95 : Icon(WeatherIcons.storm_showers),
  96 : Icon(WeatherIcons.thunderstorm),
  99 : Icon(WeatherIcons.thunderstorm),
};
