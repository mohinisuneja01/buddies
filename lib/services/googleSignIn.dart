//import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//
//
//class LoginPageWidget extends StatefulWidget {
//
//  @override
//  LoginPageWidgetState createState() => LoginPageWidgetState();
//}
//
//class LoginPageWidgetState extends State<LoginPageWidget> {
//
//  GoogleSignIn _googleSignIn = GoogleSignIn();
//  FirebaseAuth _auth;
//
//  bool isUserSignedIn = false;
//
//  @override
//  void initState() {
//    super.initState();
//
//    initApp();
//  }
//
//  void initApp() async {
//     FirebaseApp defaultApp = await Firebase.initializeApp();
//    _auth = FirebaseAuth.instanceFor(app: defaultApp);
//    checkIfUserIsSignedIn();
//  }
//
//  void checkIfUserIsSignedIn() async {
//    var userSignedIn = await _googleSignIn.isSignedIn();
//
//    setState(() {
//      isUserSignedIn = userSignedIn;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//        body: Container(
//            padding: EdgeInsets.all(50),
//            child: Align(
//                alignment: Alignment.center,
//                child: FlatButton(
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(20),
//                    ),
//                    onPressed: () {
//                      onGoogleSignIn(context);
//                    },
//                    color: isUserSignedIn ? Colors.green : Colors.blueAccent,
//                    child: Padding(
//                        padding: EdgeInsets.all(10),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          crossAxisAlignment: CrossAxisAlignment.center,
//                          children: <Widget>[
//                            Icon(Icons.account_circle, color: Colors.white),
//                            SizedBox(width: 10),
//                            Text(
//                                isUserSignedIn ? 'You\'re logged in with Google' : 'Login with Google',
//                                style: TextStyle(color: Colors.white))
//                          ],
//                        )
//                    )
//                )
//            )
//        )
//    );
//  }
//
//  Future<User> _handleSignIn() async {
//    User user;
//    bool userSignedIn = await _googleSignIn.isSignedIn();
//
//    setState(() {
//      isUserSignedIn = userSignedIn;
//    });
//
//    if (isUserSignedIn) {
//      user = _auth.currentUser;
//    }
//    else {
//      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//      final AuthCredential credential = GoogleAuthProvider.credential(
//        accessToken: googleAuth.accessToken,
//        idToken: googleAuth.idToken,
//      );
//
//      user = (await _auth.signInWithCredential(credential)).user;
//      userSignedIn = await _googleSignIn.isSignedIn();
//      setState(() {
//        isUserSignedIn = userSignedIn;
//      });
//    }
//
//    return user;
//  }
//
//  void onGoogleSignIn(BuildContext context) async {
//    User user = await _handleSignIn();
//    var userSignedIn = await Navigator.push(
//      context,
//      MaterialPageRoute(
//          builder: (context) =>
//              WelcomeUserWidget(user, _googleSignIn)),
//    );
//
//    setState(() {
//      isUserSignedIn = userSignedIn == null ? true : false;
//    });
//  }
//}
//
//class WelcomeUserWidget extends StatelessWidget {
//
//  GoogleSignIn _googleSignIn;
//  User _user;
//
//  WelcomeUserWidget(User user, GoogleSignIn signIn) {
//    _user = user;
//    _googleSignIn = signIn;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.white,
//          iconTheme: IconThemeData(color: Colors.black),
//          elevation: 0,
//        ),
//        body: Container(
//            color: Colors.white,
//            padding: EdgeInsets.all(50),
//            child: Align(
//                alignment: Alignment.center,
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    ClipOval(
//                        child: Image.network(
//                            _user.photoURL,
//                            width: 100,
//                            height: 100,
//                            fit: BoxFit.cover
//                        )
//                    ),
//                    SizedBox(height: 20),
//                    Text('Welcome,', textAlign: TextAlign.center),
//                    Text(_user.displayName, textAlign: TextAlign.center,
//                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
//                    SizedBox(height: 20),
//                    FlatButton(
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20),
//                        ),
//                        onPressed: () {
//                          _googleSignIn.signOut();
//                          Navigator.pop(context, false);
//                        },
//                        color: Colors.redAccent,
//                        child: Padding(
//                            padding: EdgeInsets.all(10),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: <Widget>[
//                                Icon(Icons.exit_to_app, color: Colors.white),
//                                SizedBox(width: 10),
//                                Text('Log out of Google', style: TextStyle(color: Colors.white))
//                              ],
//                            )
//                        )
//                    )
//                  ],
//                )
//            )
//        )
//    );
//  }
//}





//
//import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//
//import 'dart:async';
//import 'dart:convert' show json;
//
//import "package:http/http.dart" as http;
//import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//
//GoogleSignIn _googleSignIn = GoogleSignIn(
//  scopes: <String>[
//    'email',
//    'https://www.googleapis.com/auth/contacts.readonly',
//  ],
//);
//
//void main() {
//  runApp(
//    MaterialApp(
//      title: 'Google Sign In',
//      home: SignInDemo(),
//    ),
//  );
//}
//
//class SignInDemo extends StatefulWidget {
//  @override
//  State createState() => SignInDemoState();
//}
//
//class SignInDemoState extends State<SignInDemo> {
//  GoogleSignInAccount _currentUser;
//  String _contactText;
//
//  @override
//  void initState() {
//    super.initState();
//    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//      setState(() {
//        _currentUser = account;
//      });
//      if (_currentUser != null) {
//        _handleGetContact();
//      }
//    });
//    _googleSignIn.signInSilently();
//  }
//
//  Future<void> _handleGetContact() async {
//    setState(() {
//      _contactText = "Loading contact info...";
//    });
//    final http.Response response = await http.get(
//      'https://people.googleapis.com/v1/people/me/connections'
//          '?requestMask.includeField=person.names',
//      headers: await _currentUser.authHeaders,
//    );
//    if (response.statusCode != 200) {
//      setState(() {
//        _contactText = "People API gave a ${response.statusCode} "
//            "response. Check logs for details.";
//      });
//      print('People API ${response.statusCode} response: ${response.body}');
//      return;
//    }
//    final Map<String, dynamic> data = json.decode(response.body);
//    final String namedContact = _pickFirstNamedContact(data);
//    setState(() {
//      if (namedContact != null) {
//        _contactText = "I see you know $namedContact!";
//      } else {
//        _contactText = "No contacts to display.";
//      }
//    });
//  }
//
//  String _pickFirstNamedContact(Map<String, dynamic> data) {
//    final List<dynamic> connections = data['connections'];
//    final Map<String, dynamic> contact = connections?.firstWhere(
//          (dynamic contact) => contact['names'] != null,
//      orElse: () => null,
//    );
//    if (contact != null) {
//      final Map<String, dynamic> name = contact['names'].firstWhere(
//            (dynamic name) => name['displayName'] != null,
//        orElse: () => null,
//      );
//      if (name != null) {
//        return name['displayName'];
//      }
//    }
//    return null;
//  }
//
//  Future<void> _handleSignIn() async {
//    try {
//      await _googleSignIn.signIn();
//    } catch (error) {
//      print(error);
//    }
//  }
//
//  Future<void> _handleSignOut() => _googleSignIn.disconnect();
//
//  Widget _buildBody() {
//    if (_currentUser != null) {
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          ListTile(
//            leading: GoogleUserCircleAvatar(
//              identity: _currentUser,
//            ),
//            title: Text(_currentUser.displayName ?? ''),
//            subtitle: Text(_currentUser.email ?? ''),
//          ),
//          const Text("Signed in successfully."),
//          Text(_contactText ?? ''),
//          RaisedButton(
//            child: const Text('SIGN OUT'),
//            onPressed: _handleSignOut,
//          ),
//          RaisedButton(
//            child: const Text('REFRESH'),
//            onPressed: _handleGetContact,
//          ),
//        ],
//      );
//    } else {
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          const Text("You are not currently signed in."),
//          RaisedButton(
//            child: const Text('SIGN IN'),
//            onPressed: _handleSignIn,
//          ),
//        ],
//      );
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: const Text('Google Sign In'),
//        ),
//        body: ConstrainedBox(
//          constraints: const BoxConstraints.expand(),
//          child: _buildBody(),
//        ));
//  }
//}

import 'package:buddies/screens/profileSignup.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_tinder_clone/tinderHomePage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginGoogle extends StatefulWidget {
  @override
  _LoginGoogleState createState() => _LoginGoogleState();
}

class _LoginGoogleState extends State<LoginGoogle> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(253, 41, 123, 1),
              Color.fromRGBO(255, 88, 100, 1),
              Color.fromRGBO(255, 101, 91, 1)
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _handleSignIn()
                    .then((FirebaseUser user) => print(user))
                    .catchError((e) => print(e));
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileSignup()),
                      (Route<dynamic> route) => false,
                );
              },
              child: Container(
                //width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                margin: EdgeInsets.fromLTRB(24, 0, 24, 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(26)),
                child: Text(
                  "LOG IN WITH Google",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
