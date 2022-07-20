import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/components/base_card.dart';
import 'package:flutter/material.dart';
import 'package:firebase_demo/screens/place_detail_screen.dart';
import 'package:firebase_demo/services/weather_model.dart';
import 'package:http/http.dart';

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
          "พยากรณ์อากาศ 7 วันข้างหน้า",
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
        // for (int i = 0; i < 7; i++) {
          dateList.add(jsondata['SevenDaysForecast']['Date']);
          weatherList.add(jsondata['SevenDaysForecast']['WeatherDescription']);
        // }
      }
    }
    return ListView.builder(itemBuilder: (context, index) {
      return CardItem(
          date: dateList[index], weatherDescription: weatherList[index]);
    });
  }

// class CardItem extends StatelessWidget {
//   final date;
//   final weatherDescription;
//   CardItem({required this.date, required this.weatherDescription});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Expanded(
//         child: Column(
//           children: [
//             Text(date),
//             SizedBox(
//               height: 5,
//             ),
//             ListView.builder(
//               scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               // itemCount: pr.length,
//               itemBuilder: (context, index) => ListTile(
//                 // title: Text(forecastList[index]['name']),
//                 subtitle: Column(
//                   children: [
//                     // Text(sotories[index]['phone_1']),
//                     // Text(sotories[index]['phone_2']),
//                   ],
//                 ),
//                 trailing: CircleAvatar(
//                   radius: 50,
//                   // backgroundImage: NetworkImage(sotories[index]['logo_url']),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// body:
// Column(children: [
// Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//   Text(
//     // 'จังหวัด: ',
//     'จังหวัด: $pro',
//     style: TextStyle(
//       fontSize: 25.0,
//       fontWeight: FontWeight.bold,
//       color: Colors.green[800],
//     ),
//   ),
//     Padding(
//         padding: EdgeInsetsDirectional.fromSTEB(0, 4, 1, 0),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(mainAxisSize: MainAxisSize.max, children: [
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
//               child: Material(
//                 color: Colors.transparent,
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Container(
//                   width: 100,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: 48,
//                         height: 48,
//                         decoration: BoxDecoration(
//                           color: Color(0xFFF1F4F8),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           Icons.storm,
//                           color: Color(0xFF95A1AC),
//                           size: 32,
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
//                         child: Text('ฝนฟ้าคะนอง'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ]),
//         )),
//     BaseCard(
//       theChild: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Text(
//           "วันที่แนะนำให้เดินทางไป:",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 20.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.green.shade900,
//           ),
//         ),
//       ),
//       theColor: Colors.teal.shade100,
//     ),
//   ])
// ]));
// )}};

// Widget box(String date, String weatherDescription) {
//   return Container(
//       width: 90,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 8,
//             color: Color(0x230F1113),
//             offset: Offset(0, 4),
//           )
//         ],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       alignment: Alignment.center,
//       child:
//           Text(title, style: TextStyle(color: Colors.white, fontSize: 20)));
// }
}

class CardItem extends StatelessWidget {
  late final String date;
  late final String weatherDescription;
  CardItem({required this.date, required this.weatherDescription});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Expanded(
        child: Column(
          children: [
            Text(date),
            SizedBox(
              height: 5,
            ),
            Text(weatherDescription)
          ],
        ),
      ),
    );
  }
}
