import 'package:buddies/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
firebaseSignOut(BuildContext context)async{
  FirebaseAuth _auth= FirebaseAuth.instance;
  _auth.signOut();
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      loginScreen()), (Route<dynamic> route) => false);
}
