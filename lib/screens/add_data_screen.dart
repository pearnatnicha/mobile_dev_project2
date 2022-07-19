import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/base_card.dart';
import 'home_screen.dart';

class AddData extends StatefulWidget {
  const AddData({required this.email, required this.password});

  final String email;
  final String password;

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late String loggedInUser;
  String image = '';
  String name = '';
  String province = '';
  String link = '';
  String contact = '';
  String open = '';
  String map = '';
  String description = '';

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

  void updatePlace(String image, String name, String province, String link, String contact,
      String opens, String map, String description) async {
    final data = {
      "image": image,
      "place_name": name,
      "province": province,
      "link": link,
      "contact": contact,
      "opens": opens,
      "google_map_link": map,
      "description": description,
    };
    _firestore.collection('places').add(data);
  }

  Widget createDialog(BuildContext context) => CupertinoAlertDialog(
    title: Text(
      "บันทึกสถานที่",
      style: TextStyle(fontSize: 22),
    ),
    content: Text(
        "เพิ่มสถานที่เรียบร้อย",
        style: TextStyle(fontSize: 16)),
      actions: [
        CupertinoDialogAction(
          child: Text('ตกลง'),
          onPressed: () {
            Navigator.pop(context);

  }
        ),
      ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseCard(
        theChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Column(
                      children: [
                        SizedBox(height: 40),
                        Icon(Icons.photo),
                        // Text('รูปภาพ', style: TextStyle(
                        //   fontSize: 17.0,
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.green.shade900,
                        // ),)
                        SizedBox(height: 40),
                        Icon(Icons.location_city),
                        // Text('สถานที่', style: TextStyle(
                        //   fontSize: 17.0,
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.green.shade900,
                        // ),),
                        SizedBox(height: 40),
                        Icon(Icons.location_pin),
                        // Text('จังหวัด', style: TextStyle(
                        //   fontSize: 17.0,
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.green.shade900,
                        // ),),
                        SizedBox(height: 40),
                        Icon(Icons.link),
                        // Text('เว็บไซต์', style: TextStyle(
                        //   fontSize: 17.0,
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.green.shade900,
                        // ),),
                        SizedBox(height: 40),
                        Icon(Icons.phone),
                        // Text('ติดต่อ', style: TextStyle(
                        //   fontSize: 17.0,
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.green.shade900,
                        // ),),
                        SizedBox(height: 40),
                        Icon(Icons.punch_clock),
                        // Text('เวลา', style: TextStyle(
                        //   fontSize: 17.0,
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.green.shade900,
                        // ),),
                        SizedBox(height: 40),
                        Icon(Icons.map),
                        // Text('ที่ตั้ง', style: TextStyle(
                        //   fontSize: 17.0,
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.green.shade900,
                        // ),),
                        SizedBox(height: 40),
                        Icon(Icons.description),
                        // Text('เนื้อหา', style: TextStyle(
                        //   fontSize: 17.0,
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.green.shade900,
                        // ),),
                        SizedBox(height: 40),
                      ],
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              image = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'ลิงค์รูปภาพสถานที่',
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            onChanged: (value) {
                              name = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'ชื่อสถานที่',
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            onChanged: (value) {
                              province = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'จังหวัด',
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            onChanged: (value) {
                              link = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'เว็บไซต์สถานที่',
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            onChanged: (value) {
                              contact = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'เบอร์โทรติดต่อ',
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            onChanged: (value) {
                              open = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'เวลาเปิดทำการ',
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            onChanged: (value) {
                              map = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'ลิงค์ Google Map',
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            onChanged: (value) {
                              description = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'คำอธิบายสถานที่',
                            ),
                          ),
                        ],
                      ),
                    ),

                  ]),
                      SizedBox(height: 10),
                      CupertinoButton(
                        color: Colors.green,
                        child: const Text('เพิ่มสถานที่'),
                        onPressed: () {
                          updatePlace(image, name, province, link, contact, open, map, description);
                          showCupertinoDialog(
                            context: context,
                            builder: createDialog,
                          );
                        },
                      ),
                ]))
          ])),
        ),
        theColor: Colors.white70,
      ),
      backgroundColor: Colors.white70,
    );
  }
}
