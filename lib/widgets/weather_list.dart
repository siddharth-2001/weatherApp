//package imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//local imports
import '../providers/weather.dart';
import './weather_card.dart';

class WeatherListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherList>(context);
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherData.weatherList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WeatherCard(weatherData.weatherList[index]),
              ],
            ),
          );
        });
  }
}