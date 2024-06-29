import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_rescue/constants/app_constants.dart';
import 'package:my_rescue/utils/services/rest_api_services.dart';
import 'package:collection/collection.dart';
import 'package:geocoding/geocoding.dart' as geocoder;

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({super.key});

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  late Future<Weather> weatherAPI;
  String address = "";

  @override
  void initState() {
    weatherAPI = fetchWeatherAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Theme.of(context).colorScheme.primary,
      ),
      height: 220,
      alignment: Alignment.center,
      child: FutureBuilder(
        future: weatherAPI,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            getLocation(snapshot.data!.latitude, snapshot.data!.longitude);
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // * First row where it contains the user location and flood alert
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      address,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    // ? Raise the flood alert based on weather conditions
                    raiseFloodAlert(snapshot)
                        ? Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: 30,
                            color: Theme.of(context).colorScheme.secondary,
                            child: Text(
                              "Flood Alert!",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        : Container()
                  ],
                ),

                // * Second row where it contains date of five days
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      DateFormat('d/M')
                          .format(DateTime.parse(snapshot.data!.dates[0])),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat('d/M')
                          .format(DateTime.parse(snapshot.data!.dates[1])),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat('d/M')
                          .format(DateTime.parse(snapshot.data!.dates[2])),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat('d/M')
                          .format(DateTime.parse(snapshot.data!.dates[3])),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat('d/M')
                          .format(DateTime.parse(snapshot.data!.dates[4])),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),

                // * Third row where it contains the weather icons
                /** 
                 * ? Because the error of "Can't assign Icon? to Widget", I have
                 * ? set the code to behave such that, if the weather icon is null
                 * ? It will just be an empty container.
                 * */
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    weatherCodesToIcon[snapshot.data?.weatherCode[0]] ??
                        Container(),
                    weatherCodesToIcon[snapshot.data?.weatherCode[1]] ??
                        Container(),
                    weatherCodesToIcon[snapshot.data?.weatherCode[2]] ??
                        Container(),
                    weatherCodesToIcon[snapshot.data?.weatherCode[3]] ??
                        Container(),
                    weatherCodesToIcon[snapshot.data?.weatherCode[4]] ??
                        Container(),
                  ],
                ),

                // * Fourth row where it contains the day
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "TDY",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat('E')
                          .format(DateTime.parse(snapshot.data?.dates[1]))
                          .toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat('E')
                          .format(DateTime.parse(snapshot.data?.dates[2]))
                          .toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat('E')
                          .format(DateTime.parse(snapshot.data?.dates[3]))
                          .toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat('E')
                          .format(DateTime.parse(snapshot.data?.dates[4]))
                          .toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text(
              "${snapshot.error}",
              style: Theme.of(context).textTheme.displaySmall,
            );
          }
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          );
        },
      ),
    );
  }

  getLocation(latitude, longitude) async {
    var addresses =
        await geocoder.placemarkFromCoordinates(latitude, longitude);
    setState(() {
      address = addresses[0].administrativeArea.toString();
    });
  }

  // * Helper function to raise flood alert
  raiseFloodAlert(AsyncSnapshot<Weather> snapshot) {
    List<dynamic>? weatherCodeList = snapshot.data?.weatherCode;
    // Define the list of rainiy weather codes
    List rainyWeatherCode = [81, 82, 95, 96, 99];
    List rainyWeatherCodeIndex = [];
    // If the receiver is not null
    if (weatherCodeList != null) {
      // ? Loop through the weather codes list, with the index
      weatherCodeList.forEachIndexed(
        (index, element) {
          /**
           * * If the forecasted list by the API contains the thunderstorm weather codes
           * * Add the index of the weather codes to the index list
           */
          if (rainyWeatherCode.contains(element)) {
            rainyWeatherCodeIndex.add(index);
          }
        },
      );

      // Check if the indexes are consecutive in the index list
      return countConsecutiveDays(rainyWeatherCodeIndex) >= 3;
    } else {
      Exception("Weather code is null at getFloodAlert.");
    }
  }

  // * Helper function for counting consecutive days
  int countConsecutiveDays(List weatherIndex) {
    int count = 1;
    for (int i = 1; i < weatherIndex.length; i++) {
      // ? If there are already 3 consecutive days of thunderstorm, return
      if (count >= 3) {
        return count;
      }
      // ? If the previous index is the decrement of the current, then they are consecutive
      if (weatherIndex[i] == weatherIndex[i - 1] + 1) {
        count++;
      } else {
        // ? If there is a break in the consecutive days, reset the count to zero
        count = 1;
      }
    }
    return count;
  }
}
