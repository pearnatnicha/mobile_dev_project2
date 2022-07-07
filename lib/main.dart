import 'package:flutter/material.dart';
import 'home.dart';
import 'weather_forecast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Home(),
      home: WeatherForecast(),
    );
  }
}
