import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FacebookLogin fbLogin = new FacebookLogin();
  bool isFacebookLoginIn = false;
  String errorMessage = '';
  String successMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Email Login'),
      ),
      body: Center(
          child: Column(
            children: [
              (!isFacebookLoginIn
                  ? RaisedButton(
                child: Text('Facebook Login'),
                onPressed: () {
                  facebookLogin(context).then((user) {
                    if (user != null) {
                      print('Logged in successfully.');
                      setState(() {
                        isFacebookLoginIn = true;
                        successMessage =
                        'Logged in successfully.\nEmail : ${user.email}\nYou can now navigate to Home Page.';
                      });
                    } else {
                      print('Error while Login.');
                    }
                  });
                },
              )
                  : RaisedButton(
                child: Text('Facebook Logout'),
                onPressed: () {
                  facebookLoginout().then((response) {
                    if (response) {
                      setState(() {
                        isFacebookLoginIn = false;
                        successMessage = '';
                      });
                    }
                  });
                },
              )),
            ],
          )),
    );
  }

  Future<FirebaseUser> facebookLogin(BuildContext context) async {
    FirebaseUser currentUser;
    // fbLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
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

  Future<bool> facebookLoginout() async {
    await auth.signOut();
    await fbLogin.logOut();
    return true;
  }
}
//class Facebook extends StatefulWidget {
//  @override
//  _FacebookState createState() => _FacebookState();
//}
//
//class _FacebookState extends State<Facebook> {
//
//  bool _isloggedIn = false;
//  Map user;
//  final facebooklogin = FacebookLogin();
//
//  _logonwithfb() async {
//    final result = await facebooklogin.logIn(['email']);
//    switch( result.status){
//      case FacebookLoginStatus.loggedIn:
//        final token =result.accessToken.token;
//        final graphResponse =await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
//        final profile = JSON.jsonDecode(graphResponse.body);
//        print(profile);
//        setState(() {
//          user =profile;
//          _isloggedIn =true;
//        });
//        break;
//
//      case FacebookLoginStatus.cancelledByUser:
//        setState(() {
//          _isloggedIn = false;
//        }
//        );
//        break;
//      case FacebookLoginStatus.error:
//        setState(() {
//          _isloggedIn = false;
//        });
//
//
//    }
//
//  }
//
//  _logout(){
//    facebooklogin.logOut();
//    setState(() {
//      _isloggedIn= false;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: Scaffold(
//        body: Center(
//            child: _isloggedIn?
//            Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Image.network(user["picture"]["data"]["url"],height:50.0,width:50.0 ),
//                SizedBox(
//                  height: 10.0,
//                ),
//                Text('Name:${user['name']}\nEmail:${user['email']}',
//                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
//                SizedBox(
//                  height: 10.0,
//                ),
//                RaisedButton(
//                  child: Text("Logout"),
//                  onPressed: (){
//                    _logout();
//                  },
//                ),
//              ],
//
//
//            )
//                :Center(
//              child: RaisedButton(
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(12.0),
//                ),
//                child: Text("Login with Facebook"),
//                onPressed: (){
//                  _logonwithfb();
//                },
//              ),
//            )
//        ),
//
//      ),
//
//    );
//  }
//}