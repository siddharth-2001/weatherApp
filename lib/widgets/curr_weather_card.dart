//package imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//local imports
import '../providers/weather.dart';
import './weather_card.dart';

class MainWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherList>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Theme(
            data: ThemeData(
                textTheme: TextTheme(
                    bodyText1: TextStyle(color: Colors.white),
                    headline6: TextStyle(color: Colors.white),
                    bodyText2: TextStyle(color: Colors.white))),
            child: WeatherCard(weatherData.currWeather!)),
        IconButton(
            onPressed: () {
              //Provider.of<WeatherList>(context, listen: false).fetchWeather();
            },
            icon: const Icon(
              Icons.replay_outlined,
              color: Colors.white,
            ))
      ],
    );
  }
}
