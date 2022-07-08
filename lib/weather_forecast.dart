import 'package:firebase_demo/base_card.dart';
import 'package:flutter/material.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({Key? key}) : super(key: key);
  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "    พยากรณ์อากาศ",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.green[900],
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.green[200],
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text(
              'พยากรณ์อากาศล่วงหน้า 7 วัน',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
                BaseCard(
                  theChild: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "วันที่อากาศเหมาะสม:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                    ),
                  ),
                  theColor: Colors.teal.shade100,
                ),
          ]),
        ));
  }
}
