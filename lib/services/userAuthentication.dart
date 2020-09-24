import 'package:buddies/screens/authenticationScreen.dart';
import 'package:buddies/screens/profileSignup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


Future<bool> loginUser(String phone, BuildContext context) async {
  final _codeController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();
        FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
        print(user == null);
        if (user != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileSignup()));
        } else {
          print("Error");
        }

        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (AuthException exception) {
        print(exception);
      },
      codeSent: (String verificationId, [int forceResendingToken]) =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              AuthenticationScreen(verificationId: verificationId,auth:_auth))),
      codeAutoRetrievalTimeout: null);




//showDialog(
//context: context,
//barrierDismissible: false,
//builder: (context) {
//return AlertDialog(
//title: Text("Give the code?"),
//content: Column(
//mainAxisSize: MainAxisSize.min,
//children: <Widget>[
//TextField(
//controller: _codeController,
//keyboardType: TextInputType.number,
//),
//],
//),
//actions: <Widget>[
//FlatButton(
//child: Text("Confirm"),
//textColor: Colors.white,
//color: Colors.teal,
//onPressed:
//},
//)
//],
//);
//});
}