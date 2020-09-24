import 'package:buddies/screens/profileSignup.dart';
import 'package:buddies/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:async';
import 'package:buddies/services/userAuthentication.dart';
import '../services/userAuthentication.dart';
class AuthenticationScreen extends StatefulWidget {
  String verificationId;
  FirebaseAuth auth;
  AuthenticationScreen({this.verificationId,this.auth,this.phone});
  String phone;
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState(verificationId: verificationId,auth: auth,phone: phone);
}


class _AuthenticationScreenState extends State<AuthenticationScreen>  {
  @override
  void initState() {
    _startTimer();
    super.initState();
  }
  int _counter = 60;
  Timer _timer;
  int check=0;
  void _startTimer() {
    _counter = 60;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }
 String phone;
  TextEditingController _codeController=TextEditingController();
  String verificationId;
  FirebaseAuth auth;

  _AuthenticationScreenState({this.verificationId,this.auth,this.phone});

  @override
  Widget build(BuildContext context) {
    if(_counter==0)
      check=1;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/BG3.png',),fit: BoxFit.cover
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40,),
              Container(
                width: MediaQuery.of(context).size.width*0.8,
                height: 50,
                child: Center(child: Text('Connect with fellow students',style: TextStyle(fontSize: 20,color: Colors.grey[800],fontWeight: FontWeight.bold),)),

              ),
              SizedBox(height: 35,),
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.95,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Text("Please enter the code received",style: TextStyle(fontSize:16,color: Colors.grey[600] ),),
                      SizedBox(height: 35,),
                      Container(
                        width: MediaQuery.of(context).size.width*0.35,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.grey,
                          controller: _codeController,
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(

                            //contentPadding: EdgeInsets.only(bottom: 0,left: 13,right: 9),
                            hintText: 'Enter the code',
                            hintStyle: TextStyle(color: Colors.grey[350]),
                            enabledBorder:UnderlineInputBorder (
                                borderSide: BorderSide(color: Colors.black,width:1 )
                            ),
                            focusedBorder: UnderlineInputBorder (
                                borderSide: BorderSide(color: Colors.black,width:1 )
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Center(child:

                      Text((_counter>9)?'00:$_counter':'00:0$_counter',style: TextStyle(color: (_counter!=0)?Colors.grey[450]:Colors.grey[350],fontSize: 18),)
                       ),


                      SizedBox(height: 5,),
                      FlatButton(child: Text('Resend',style: TextStyle(fontSize: 15,color: (_counter!=0)?Colors.grey[350]:Colors.grey[450]),),onPressed:(_counter==0)?()=>onPressed2(phone, context):null,),
                      SizedBox(height: 5,),
                      CustomButton2(context, "Next",onPressed ),
                      SizedBox(height: 15,)

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  onPressed() async {



          final code = _codeController.text.trim();
    AuthCredential credential =
    PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);

    FirebaseUser user =
        (await auth.signInWithCredential(credential)).user;

    if (user != null) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileSignup()));
    } else {
      print("Error");
    }
  }
  onPressed2(String phone, BuildContext context) {
      _startTimer();
      loginUser(phone, context);
  }

}



