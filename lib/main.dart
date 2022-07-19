import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/navigator_bar.dart';
import 'screens/weather_forecast_screen.dart';
import 'screens/add_data_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Register(),
      home: Login(),
      // home: Home(email: "admin@gmail.com", password: "password",),
      // home: AddData(email: "admin@gmail.com", password: "password",),
      // home: WeatherForecast(),
    );
  }
}
