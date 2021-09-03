//package imports
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//local imports
import '../providers/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  WeatherCard(this.weather);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text(
            weather.condition,
            style: theme.textTheme.headline6,
          ),
          Text(
            '${((weather.maxTemp + weather.minTemp) / 2).round()}°C',
            style: theme.textTheme.bodyText1,
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 50,
            child: Image.network(
              'https://openweathermap.org/img/wn/${weather.iconCode}.png',
              loadingBuilder: (context, child, loadingPorgress) {
                if (loadingPorgress == null) {
                  
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            DateFormat.yMMMd().format(weather.dateTime),
            style: theme.textTheme.bodyText1,
          ),
          Text(
            DateFormat.Hm().format(weather.dateTime),
            style: theme.textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}