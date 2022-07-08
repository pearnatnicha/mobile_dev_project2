import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FirebaseFirestore _firestore;

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
  }

  void getPlaces() async {
    final places = await _firestore
        .collection('places')
        .get();
    //Here is the list of messages
    for (var place in places.docs) {
      String aPlace = place.get('place_name') + ':' + place.get('description');
      print(aPlace);
    }
  }

  void updatePlace() async {
    final data = {
      "place_name": "พิพิธภัณฑ์การเกษตรเฉลิมพระเกียรติฯ Wisdom Farm",
      "province": "ปทุมธานี",
      "keyword": ['ปทุมธานี', 'พิพิธภัณฑ์การเกษตรเฉลิมพระเกียรติฯ Wisdom Farm', 'เศรฐกิจพอเพียง'],
      "link": "https://www.wisdomking.or.th/th",
      "contact": "025292212",
      "opens": "ททุกวัน 09.00-16.00 น.",
      "google_map_link": "https://www.google.com/maps/dir/?api=1&destination=14.117899835872%2C100.62608063221",
      "description": "พิพิธภัณฑ์การเกษตรเฉลิมพระเกียรติฯ Wisdom Farm เป็นแหล่งเรียนรู้การเกษตรเศรฐกิจพอเพียงเพื่อส่งเสริมให้ผู้คนได้ลองมาสัมผัสวิถีชีวิตแบบพอเพียงเพื่อประโยชน์ของประชาชน ด้วยพื้นที่กว่า 300 ไร่ ทางพิพิธภัณฑ์จึงแบ่งออกเป็น 2 โซนใหญ่ๆ คือ พิพิธภัณฑ์ในอาคาร และ พิพิธภัณฑ์การเรียนรู้กลางแจ้ง ในส่วนของ พิพิธภัณฑ์ในอาคาร จะมีการจัดแสดงเกี่ยวกับ ศาสตร์พระราชา เพื่อนำมาประยุกต์ใช้ในการเกษตรของ พระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร รัชกาลที่ 9 ส่วน พิพิธภัณฑ์การเรียนรู้กลางแจ้ง จะเป็นเขตของไร่นาและพืชผักต่างๆ ที่ทำให้เราได้ลองไปสัมผัสและลงมือทำด้วยตนเอง เช่น การสร้างบ้านดิน การใช้โซลาร์เซลล์เพื่อสร้างพลังงานทดแทน รวมถึงเวิร์คชอปวิถีเกษตร และวัฒนธรรมต่างๆ"
    };
    _firestore.collection('places').add(data);
  }

  void deletePlace() async {
    final places = await _firestore.collection('places')
        .where("place_name", isEqualTo: '')
        .get();
    //Here is the list of messages
    for (var place in places.docs) {
      _firestore.collection('places').doc(place.id).delete();
    }
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              // logout
              // getPlaces();
              // deletePlace();
              updatePlace();
            },
          )
        ],
      ),
    );
  }
}
