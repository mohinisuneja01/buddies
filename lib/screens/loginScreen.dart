
import 'package:buddies/screens/profileSignup.dart';
import 'package:buddies/services/facebookLogin.dart';
import 'package:buddies/services/googleSignIn.dart';
import 'package:buddies/services/userAuthentication.dart';
import 'package:buddies/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  GoogleSignInAccount _currentUser;
  String _contactText;
  final _phoneController = TextEditingController();
  TextEditingController userNameController=TextEditingController();
  bool _isloggedIn = false;
  Map user;
  final facebooklogin = FacebookLogin();

  _logonwithfb() async {
    final result = await facebooklogin.logIn(['email']);
    switch( result.status){
      case FacebookLoginStatus.loggedIn:
        final token =result.accessToken.token;
        final graphResponse =await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          user =profile;
          _isloggedIn =true;
        });

        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          _isloggedIn = false;
        }
        );
        break;
      case FacebookLoginStatus.error:
        setState(() {
          _isloggedIn = false;
        });


    }

  }

  _logout(){
    facebooklogin.logOut();
    setState(() {
      _isloggedIn= false;
    });
  }


  String countryCode='+91';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('lib/images/bg1.png'),fit: BoxFit.cover)
          ),
        //    padding: EdgeInsets.only(top: 180,left: 20,right: 20,bottom: 180),
            child: Column(
              children: <Widget>[
            Center(
            child: Padding(
              padding: const EdgeInsets.only(top:45.0),
              child: Container(
                height: 35,
                width: MediaQuery.of(context).size.width*0.33,
                // constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('lib/images/buddies.png'),fit: BoxFit.cover),
                ),
              ),
            ),),
                Padding(
                  padding: const EdgeInsets.only(top: 50,left: 20,right: 20,bottom: 0),
                  child: Card(
                    child:
                       Column(
                       // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 15,bottom: 29),
                              child: Text("Login with your phone number", style: TextStyle(color: Colors.black, fontSize: 16),),
                            ),

                         // SizedBox(height: 16,),
//                  InternationalPhoneNumberInput(
//
//                    onInputChanged: (PhoneNumber phone){
//                      print(phone.phoneNumber);
//                    },
//                    isEnabled: true,
//                    initialValue:number ,
//                    textFieldController: _phoneController,
//                    onSubmit: (){
//                      loginUser(_phoneController.text, context);
//                    },
//
//                  ),


                          Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              CountryCodePicker(
                                enabled: false,
                                showFlag: false,
                                textStyle: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.normal),
                                onChanged: (CountryCode code){
                                  countryCode=code.dialCode;
                                },
                                initialSelection: 'IN',
                                onInit: (CountryCode code){
                                  countryCode=code.dialCode;
                                },
                              ),
                              Container(
                               //   padding: EdgeInsets.only(top:0,left: 0,right: 0,bottom: 0),
                                width: MediaQuery.of(context).size.width/1.7,
                                child:
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: TextField(
                                    style: TextStyle(fontSize: 17),
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      focusColor: Colors.black,

                                          enabledBorder:UnderlineInputBorder (
                                              borderSide: BorderSide(color: Colors.black,width:1 )
                                          ),
                                          focusedBorder: UnderlineInputBorder (
                                              borderSide: BorderSide(color: Colors.black,width:1 )
                                          ),
                                 filled: true,
                                        fillColor: Colors.white,
                                    ),
                                    //    hintText: "Mobile Number"

                                    //),
                                    controller: _phoneController,
                                  ),
                                ),
                              ),
                            ],
                          ),
SizedBox(height: 60,),
                          CustomButton2(context, "Next", () {
                final String phone = countryCode+_phoneController.text.trim();
                print(phone);
                loginUser(phone, context);
              }),



                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                ),
                SizedBox(height: 50,),
                customButton(buttonName: 'Connect with Facebook',onPressed:(){
                  _isloggedIn?Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileSignup())):login();
                } ),
                SizedBox(height: 20,),
                customButton(buttonName: 'Connect with Google',onPressed:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginGoogle()))
//                { if(_currentUser==null) {
//                _handleSignIn();
//                if(_currentUser!=null)
//                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileSignup())); }
//                else{
//    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileSignup()));
//
//    }}
)
              ],
            ),
            ),
          ),
//      Center(
//        child: Container(
//          width:MediaQuery.of(context).size.width*0.3,
//          height: 40,
//          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('lib/images/Button.png'),fit: BoxFit.cover),
//          ),
//          child: Center(child: InkWell(
//              onTap: () {
//                final String phone = countryCode+_phoneController.text.trim();
//                print(phone);
//                loginUser(phone, context);
//
//              },child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 20),))),
//        ),
//      ),




    );
  }
//  _ShowFormInDialog(BuildContext context) {
//    var firestoreDb = Firestore.instance.collection('user');
//
//
//    return showDialog(
//
//        context: context, barrierDismissible: true, builder: (param) =>
//        AlertDialog(
//          actions: <Widget>[
//            RaisedButton(
//              child: Text("Save"),
//              onPressed: () async {
//                if(userNameController.text!=null)
//                  await  firestoreDb.document().setData({'Questions':{'${userNameController.text}':List()}},merge:true);
////                  await  firestoreDb.document(name).setData({'Questions':[{'${subjectDetailController.text}':[]}]},merge:true);
//                userNameController.clear();
//                Navigator.of(context).pop();
//              },
//            ),
//            FlatButton(
//              child: Text("cancel"),
//              onPressed: () {
//                userNameController.clear();
//                Navigator.of(context).pop();
//              },
//            )
//          ],
//          title: Text("Add Question"),
//          content: SingleChildScrollView(
//            child: Column(
//              children: <Widget>[
//                TextField(
//                  controller: userNameController,
//                  decoration: InputDecoration(
//                    labelText: "Question",
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ));
//  }

Widget customButton({String buttonName,onPressed}){
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          width: MediaQuery.of(context).size.width*0.7,
          height: 40,
          child: Center(child: Text(buttonName)),
        ),
      ),
    );
}



  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact() async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = JSON.jsonDecode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

//

  login(){

    _logonwithfb();
     if(_isloggedIn==true)
     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileSignup()));
  }
}



GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);


