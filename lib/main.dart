//package imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//local imports
import './screens/weather_screen.dart';
import './providers/weather.dart';

void main() {
  return runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherList>(
          create: (context) => WeatherList(),
        ),
      ],
      child: MaterialApp(
        title: 'newsApp',
        theme: ThemeData(),
        home: WeatherScreen(),
        routes: {
          WeatherScreen.routeName: (context) => WeatherScreen(),
        },
      ),
    );
  }
}
