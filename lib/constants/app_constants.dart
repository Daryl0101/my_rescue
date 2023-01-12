import 'package:flutter/material.dart';
import 'package:my_rescue/config/themes/theme_config.dart';
import 'package:weather_icons/weather_icons.dart';

// Map of WMO Weather interpretation codes with weather icons
// https://open-meteo.com/en/docs#latitude=5.37&longitude=100.25&daily=weathercode&timezone=Asia%2FSingapore:~:text=Weather%20variable%20documentation
Map<int, Icon> weatherCodesToIcon = const {
  0 : Icon(WeatherIcons.day_sunny, color: myRescueOrange,),
  1 : Icon(WeatherIcons.day_cloudy, color: myRescueOrange,),
  2 : Icon(WeatherIcons.cloudy, color: myRescueOrange,),
  3 : Icon(WeatherIcons.day_sunny_overcast, color: myRescueOrange,),
  45 : Icon(WeatherIcons.fog, color: myRescueOrange,),
  48 : Icon(WeatherIcons.fog, color: myRescueOrange,),
  51 : Icon(WeatherIcons.day_showers, color: myRescueOrange,),
  53 : Icon(WeatherIcons.day_showers, color: myRescueOrange,),
  55 : Icon(WeatherIcons.showers, color: myRescueOrange,),
  56 : Icon(WeatherIcons.day_sleet, color: myRescueOrange,),
  57 : Icon(WeatherIcons.sleet, color: myRescueOrange,),
  61 : Icon(WeatherIcons.rain_mix, color: myRescueOrange,),
  63 : Icon(WeatherIcons.rain, color: myRescueOrange,),
  65 : Icon(WeatherIcons.rain_wind, color: myRescueOrange,),
  66 : Icon(WeatherIcons.rain, color: myRescueOrange,),
  67 : Icon(WeatherIcons.rain_wind, color: myRescueOrange,),
  71 : Icon(WeatherIcons.snow, color: myRescueOrange,),
  73 : Icon(WeatherIcons.snow, color: myRescueOrange,),
  75 : Icon(WeatherIcons.snow, color: myRescueOrange,),
  77 : Icon(WeatherIcons.snow, color: myRescueOrange,),
  80 : Icon(WeatherIcons.showers, color: myRescueOrange,),
  81 : Icon(WeatherIcons.showers, color: myRescueOrange,),
  82 : Icon(WeatherIcons.showers, color: myRescueOrange,),
  85 : Icon(WeatherIcons.day_snow_wind, color: myRescueOrange,),
  86 : Icon(WeatherIcons.day_snow_wind, color: myRescueOrange,),
  95 : Icon(WeatherIcons.storm_showers, color: myRescueOrange,),
  96 : Icon(WeatherIcons.thunderstorm, color: myRescueOrange,),
  99 : Icon(WeatherIcons.thunderstorm, color: myRescueOrange,),
};
