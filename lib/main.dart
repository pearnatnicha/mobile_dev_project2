import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'login.dart';
import 'home.dart';
import 'weather_forecast.dart';
import 'addData.dart';

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
