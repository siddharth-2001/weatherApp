//package imports
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather {
  final double maxTemp;
  final double minTemp;
  final String condition;
  final DateTime dateTime;
  final String iconCode;

  Weather({
    required this.condition,
    required this.maxTemp,
    required this.minTemp,
    required this.dateTime,
    required this.iconCode,
  });
}

class WeatherList with ChangeNotifier {
  Weather? currWeather;

  List<Weather> _weatherList = [];

  List<Weather> get weatherList {
    return [..._weatherList];
  }

  Future<void> fetchWeather(lat, long) async {
    List<Weather> loadedWeather = [];
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely,hourly,alerts&units=metric&appid=8944b690fb4f25ef8a4974f905e79eae');
    final response = await http.get(
      url,
    );
    final weatherData = jsonDecode(response.body) as Map<String, dynamic>;
    final currData = weatherData['current'] as Map<String, dynamic>;
    //print(currData['weather'][0]['main']);
    currWeather = Weather(
        iconCode: currData['weather'][0]['icon'],
        condition: currData['weather'][0]['main'],
        minTemp: currData['temp'],
        maxTemp: currData['temp'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(currData['dt'] * 1000));

    final dailyWeather = weatherData['daily'] as List<dynamic>;
    // print(dailyWeather);
    dailyWeather.forEach((element) {
      // print(element);
      loadedWeather.add(Weather(
          iconCode: element['weather'][0]['icon'],
          condition: element['weather'][0]['main'],
          minTemp: element['temp']['min'],
          maxTemp: element['temp']['min'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(element['dt'] * 1000)));
    });
    notifyListeners();
    _weatherList = loadedWeather;
  }
}