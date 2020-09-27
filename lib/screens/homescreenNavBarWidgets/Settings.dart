import 'package:buddies/services/SignOut.dart';
import 'package:flutter/material.dart';
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"),),
      body: Center(child:
        RaisedButton(
          child: Text('Sign Out'),
          onPressed: (){firebaseSignOut(context);},
        ),),
    );
  }
}
