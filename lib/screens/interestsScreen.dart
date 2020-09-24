import 'package:flutter/material.dart';

class InterestsScreen extends StatefulWidget {
  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        child: Text("Data uploaded to Firebase"),
      )),
    );
  }
}
