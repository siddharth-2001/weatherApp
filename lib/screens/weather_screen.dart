//package imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

//local imports
import '../providers/weather.dart';
import '../widgets/weather_list.dart';
import '../widgets/curr_weather_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);
  static const routeName = '/weather';

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var _lat;
  var _long;

  Future<void> getLoc() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final loc = await Geolocator.getCurrentPosition();
    _lat = loc.latitude;
    _long = loc.longitude;
  }

  @override
  void initState() {
    getLoc().then((value) => Provider.of<WeatherList>(context, listen: false)
        .fetchWeather(_lat, _long));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherList>(context);
    final appBar = AppBar(
      title: Text('Flutter Weather App'),
    );
    return Scaffold(
        appBar: appBar,
        backgroundColor: Color.fromRGBO(94, 124, 139, 1),
        body: weatherData.currWeather == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: MainWeather(_lat, _long),
                  ),
                  Expanded(
                    flex: 1,
                    child: WeatherListView(),
                  )
                ],
              ));
  }
}
