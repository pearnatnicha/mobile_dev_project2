import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/screens/place_detail_screen.dart';
import 'package:firebase_demo/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'add_data_screen.dart';
import 'register_screen.dart';
import 'login_screen.dart';

class Home2 extends StatefulWidget {
  const Home2({required this.email, required this.password});

  final String email;
  final String password;

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late String loggedInUser;
  String place = '';
  String? _chosenValue = '';
  List<String> value = ['กรุงเทพ', 'สมุทรสงคราม', 'ชลบุรี', 'จันทบุรี'];
  // List<Map<String, dynamic>> data =

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    // await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    await _auth.signInWithEmailAndPassword(
        email: widget.email, password: widget.password);

    loggedInUser = _auth.currentUser?.email ?? 'none';
    print('The loggedInUser is $loggedInUser');
  }

  // void getPlaces() async {
  //   final places = await _firestore.collection('places').get();
  //   for (var place in places.docs) {
  //     String aPlace = place.get('place_name') + ':' + place.get('description');
  //     print(aPlace);
  //   }
  // }

  getPlaces() async {
    QuerySnapshot places = await _firestore.collection('places').get();
    return places.docs;
    // var firestore = FirebaseFirestore.instance;
    // QuerySnapshot qn = await firestore.collection("places").get();
    // return qn.docs;
  }

  void deletePlace() async {
    final places = await _firestore
        .collection('places')
        .where("place_name", isEqualTo: '')
        .get();
    for (var place in places.docs) {
      _firestore.collection('places').doc(place.id).delete();
    }
  }

  navigateToDetail(DocumentSnapshot place) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Place(place: place)));
  }

  @override
  Widget build(BuildContext context) {
    return
        // Column(
        // children: [
        //   Container(
        //     child: DropdownButton<String>(
        //       value: _chosenValue,
        //       items:
        //       value.map((value) => DropdownMenuItem<String>(
        //           value: value,
        //       child: Text(value, style: TextStyle(fontSize: 24)),
        //       )).toList(),
        //       onChanged: (value) => setState(() {
        //         _chosenValue = value;
        //       }),
        //       ),
        //     ),
        Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('places').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading..."),
            );
          } else {
            final snap = snapshot.data!.docs;
            return ListView.builder(
                itemCount: snap.length,
                itemBuilder: (context, index) {
                  // return ListTile(
                  //   title: Text(snap[index]["place_name"]),
                  //   onTap: () => navigateToDetail(snap[index]),
                  // );
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                    child: Container(
                      width: 270,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Color(0x230F1113),
                            offset: Offset(0, 4),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () => navigateToDetail(snap[index]),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                snap[index]["image"],
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16, 12, 16, 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snap[index]["place_name"],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[900],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.place),
                                          Text(snap[index]["province"]),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
    // ],
    // );
  }
}

// Scaffold(
// body: StreamBuilder<QuerySnapshot>(
// stream: _firestore.collection('places').snapshots(),
// builder: (context, snapshots) {
// return (snapshots.connectionState == ConnectionState.waiting)
// ? Center(
// child: CircularProgressIndicator(),
// )
//     :ListView.builder(
// itemCount: snapshots.data?.docs.length,
// itemBuilder: (context, index) {
// // var data = snapshots.data?.docs[index].data()
// //     as Map<String, dynamic>;
// final places = await _firestore.collection('places').get();
// if place
// }
// )
// },
// ),
// );
