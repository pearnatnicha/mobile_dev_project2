import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/register.dart';
import 'package:flutter/material.dart';
import 'addData.dart';
import 'register.dart';
import 'login.dart';
import 'home2.dart';

class Home extends StatefulWidget {
  const Home({required this.email, required this.password});

  final String email;
  final String password;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String loggedInUser;

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late List<Widget> _widgetOptions = [
    Home2(email: widget.email, password: widget.password),
    AddData(email: widget.email, password: widget.password),
    // Login(),
  ];



  @override
  void initState() {
    super.initState();
  }



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
            // backgroundColor: Color(0xFFC5E1A5),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'เพิ่มสถานที่',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.favorite),
          //   label: 'รายการโปรด',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[900],
        onTap: _onItemTapped,
      ),
    );
  }
}
