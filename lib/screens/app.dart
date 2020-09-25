import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'package:buddies/screens/profileSignup.dart';
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
Widget homeScreen;
FirebaseAuth _auth;
@override
  void initState() {
  super.initState();
  _auth = FirebaseAuth.instance;
  assignScreen();
  }
  @override
  Widget build(BuildContext context) {

    return homeScreen??Container(color: Colors.white,);
  }

  assignScreen() async {
    await _auth.currentUser().then((user)
    {
      setState(() {
        homeScreen=(user==null)? loginScreen():ProfileSignup();
      });
    });
  }
}