import 'package:firebase_auth/firebase_auth.dart';
Future<FirebaseUser> getUser() async {
  FirebaseUser User;
     final FirebaseAuth _auth=FirebaseAuth.instance;
    User=await _auth.currentUser().then((user)=>user
    );

     return User;
  }