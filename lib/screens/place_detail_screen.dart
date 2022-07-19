import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/screens/weather_forecast_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Place extends StatefulWidget {
  final DocumentSnapshot place;
  Place({required this.place});

  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Emeralds",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[200],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Card(
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    widget.place['place_name'],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                ),
                subtitle: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(widget.place['description'])),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.place),
                Text(widget.place['province']),
                SizedBox(width: 20),
                TextButton(
                  child: const Text('Google Map'),
                  onPressed: () async {
                    String url = widget.place['google_map_link'];
                    await launchUrlString(url);
                    // if (await canLaunchUrl(Uri.parse(url))) {
                    //   await launchUrlString(url);
                    // }
                  },
                ),
              ],
            ),
            Text("เวลาเปิดทำการ: " + widget.place['opens']),
            Text("ติดต่อ: " + widget.place['contact']),
            SizedBox(height: 20),
            Image.network(widget.place['image']),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                // MaterialPageRoute(
                //   builder: (context) {
                //     return WeatherForecast();
                //   },
                // );
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherForecast(province: widget.place['province'])));
                });
              },
              height: 45,
              minWidth: 240,
              child: const
              Text(
                'ตรวจสอบพยากรณ์อากาศ',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              textColor: Colors.white,
              color: Colors.green.shade700,
              shape: const StadiumBorder(),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
