import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class WeatherForecast extends StatefulWidget {
  WeatherForecast({required this.province});
  final String province;
  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  List jsonArray = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchData();
  }

  fetchData() async {
    var response = await http
        .get(Uri.parse('https://data.tmd.go.th/api/WeatherForecast7Days/V1'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body)["Provinces"];
      setState(() {
        jsonArray = data;
      });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String _province = widget.province;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "พยากรณ์อากาศ จ.$_province",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.green[200],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (jsonArray.contains(null) || jsonArray.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    List dateList = [];
    List weatherList = [];
    for (var jsondata in jsonArray) {
      if (widget.province == jsondata['ProvinceNameTh']) {
        for (int i = 0; i < 7; i++) {
          // print(jsondata['SevenDaysForecast'][i]['Date']);
          dateList.add(jsondata['SevenDaysForecast'][i]['Date']);
          weatherList
              .add(jsondata['SevenDaysForecast'][i]['WeatherDescription']);
        }
      }
    }
    // print(dateList);
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: dateList.length,
        itemBuilder: (context, index) {
          return CardItem(
              date: dateList[index], weatherDescription: weatherList[index]);
        });
  }
}

class CardItem extends StatelessWidget {
  late final String date;
  late final String weatherDescription;
  CardItem({required this.date, required this.weatherDescription});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(130, 10, 1, 0),
        child: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
              child: Material(
                color: Colors.transparent,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(date),
                      Container(
                        width: 48,
                        height: 53,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.thunderstorm,
                          color: Color(0xFF95A1AC),
                          size: 32,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, 8, 0, 0),
                        child: Text(weatherDescription),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
