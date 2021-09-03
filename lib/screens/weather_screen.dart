//package imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

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
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData loc;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    } //checks whether location service is enabled ondevice,
    //if not it requests the user to enable it and returns if not enabled

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    } //checks whether app has permision to acess location,if not it requests permission
    //if permission is denied, it returns

    try {
      loc = await location.getLocation();
      _lat = loc.latitude;
      _long = loc.longitude;
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
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
                    child: MainWeather(),
                  ),
                  Expanded(
                    flex: 1,
                    child: WeatherListView(),
                  )
                ],
              ));
  }
}
