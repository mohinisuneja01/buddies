import 'package:buddies/screens/profileSignup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

LoginFacebook(BuildContext context)async{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FacebookLogin fbLogin = new FacebookLogin();
  Future<FirebaseUser> facebookLogin(BuildContext context) async {
    FirebaseUser currentUser;
//     fbLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    // if you remove above comment then facebook login will take username and pasword for login in Webview
    try {
      final FacebookLoginResult facebookLoginResult =
      await fbLogin.logIn(['email', 'public_profile']) ;
      if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        FacebookAccessToken facebookAccessToken =
            facebookLoginResult.accessToken;
        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: facebookAccessToken.token);
        final FirebaseUser user = (await auth.signInWithCredential(credential)).user   ;
        assert(user.email != null);
        assert(user.displayName != null);
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);
        currentUser = await auth.currentUser();
        assert(user.uid == currentUser.uid);
        return currentUser;
      }
    } catch (e) {
      print(e);
    }
    return currentUser;
  }
  facebookLogin(context).then((user) {
    if (user != null) {
      print('Logged in successfully.');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ProfileSignup()),
            (Route<dynamic> route) => false,
      );
    } else {
      print('Error while Login.');
    }
  });
}