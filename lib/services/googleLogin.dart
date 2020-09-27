import 'package:buddies/screens/profileSignup.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


GoogleLogin(BuildContext context){
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth =
  await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user =
      (await _auth.signInWithCredential(credential)).user;
  print("signed in " + user.email);
  return user;
}

  _handleSignIn()
      .then((FirebaseUser User) {

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => ProfileSignup()),
          (Route<dynamic> route) => false,
    );
  })
      .catchError((e) => print(e));
}
