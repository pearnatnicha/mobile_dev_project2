import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/components/base_card.dart';
import 'package:flutter/material.dart';
import 'package:firebase_demo/screens/place_detail_screen.dart';

class WeatherForecast extends StatefulWidget {
  // const WeatherForecast({Key? key, required province}) : super(key: key);
  // final DocumentSnapshot province;
  WeatherForecast({required this.province});

  final String province;

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  @override
  Widget build(BuildContext context) {
    String pro = widget.province;
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
        body: Column(children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              // 'จังหวัด: ',
              'จังหวัด: $pro',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 1, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(mainAxisSize: MainAxisSize.max, children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
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
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1F4F8),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.storm,
                                  color: Color(0xFF95A1AC),
                                  size: 32,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: Text('ฝนฟ้าคะนอง'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                )),
            BaseCard(
              theChild: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "วันที่แนะนำให้เดินทางไป:",
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
          ])
        ]));
  }

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

// class IndexPage extends StatefulWidget {
//   @override
//   _IndexPageState createState() => _IndexPageState();
// }
//
// class _IndexPageState extends State<IndexPage> {
//   List users = [];
//   bool isLoading = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     this.fetchUser();
//   }
//   fetchUser() async {
//     setState(() {
//       isLoading = true;
//     });
//     var url = Uri.parse("https://randomuser.me/api/?results=50");
//     var response = await http.get(url);
//     // print(response.body);
//     if(response.statusCode == 200){
//       var items = json.decode(response.body)['results'];
//       setState(() {
//         users = items;
//         isLoading = false;
//       });
//     }else{
//       users = [];
//       isLoading = false;
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Listing Users"),
//       ),
//       body: getBody(),
//     );
//   }
//   Widget getBody(){
//     if(users.contains(null) || users.length < 0 || isLoading){
//       return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff4f359b)),));
//     }
//     return ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context,index){
//           return getCard(users[index]);
//         });
//   }
//   Widget getCard(item){
//     var fullName = item['name']['title']+" "+item['name']['first']+" "+item['name']['last'];
//     var email = item['email'];
//     var profileUrl = item['picture']['large'];
//     return Card(
//       elevation: 1.5,
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: ListTile(
//           title: Row(
//             children: <Widget>[
//               Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                     color: Color(0xff4f359b),
//                     borderRadius: BorderRadius.circular(60/2),
//                     image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: NetworkImage(profileUrl)
//                     )
//                 ),
//               ),
//               SizedBox(width: 20,),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   SizedBox(
//                       width: MediaQuery.of(context).size.width-140,
//                       child: Text(fullName,style: TextStyle(fontSize: 17),)),
//                   SizedBox(height: 10,),
//                   Text(email.toString(),style: TextStyle(color: Colors.grey),)
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
