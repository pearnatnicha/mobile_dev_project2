import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/home.dart';
import 'package:firebase_demo/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';
import 'register.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late FirebaseAuth _auth;
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
  }

  void fireToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green.shade900,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade900,
              Colors.green,
              Colors.green.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 210,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text('Emeralds',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.5,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 7.5),
                  Text('travel eco, travel fun',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  SizedBox(height: 7.5),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 10,
                                offset: const Offset(0, 10)),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextField(
                            onChanged: (value) {
                              email = value;
                            },
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: 'Email',
                                isCollapsed: false,
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                          ),
                          Divider(color: Colors.black54, height: 1),
                          TextField(
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: 'รหัสผ่าน',
                                isCollapsed: false,
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),
                    MaterialButton(
                      onPressed: () async {
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (user != null) {
                            print("$email is in.");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Home(email: email, password: password);
                                },
                              ),
                            );
                          } else {
                            print("Login failed");
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      height: 45,
                      minWidth: 240,
                      child: const Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      textColor: Colors.white,
                      color: Colors.green.shade700,
                      shape: const StadiumBorder(),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'เพิ่งเคยเข้ามาใน Emeralds ใช่หรือไม่',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      child: const Text('สมัครใหม่'),
                      onPressed: () {
                        print('register');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Register();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
      // @override
      // Widget build(BuildContext context) {
      //   return Scaffold(
      //     body: Column(
      //       children: [
      //         const SizedBox(height: 30),
      //         TextField(
      //           onChanged: (value) {
      //             email = value;
      //           },
      //           decoration: const InputDecoration(
      //             hintText: 'email',
      //           ),
      //         ),
      //         TextField(
      //           onChanged: (value) {
      //             password = value;
      //           },
      //           decoration: const InputDecoration(
      //             hintText: 'password',
      //           ),
      //         ),
      //         TextButton(
      //             child: const Text('Login'),
      //             onPressed: () async {
      //               //print("login with $email , $password");
      //               try {
      //                 final user = await _auth.signInWithEmailAndPassword(
      //                     email: email, password: password);
      //                 if (user != null) {
      //                   print("$email is in.");
      //                 } else {
      //                   print("Login failed");
      //                 }
      //               } catch (e) {
      //                 print(e);
      //               }
      //             }),
      //         TextButton(
      //           child: const Text('Register'),
      //           onPressed: () {
      //             print('register');
      //           },
      //         ),
      //       ],
      //     ),
    );
  }
}
