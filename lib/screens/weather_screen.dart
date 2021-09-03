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
    final loc = await Location().getLocation();
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
