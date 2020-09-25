
import 'package:buddies/services/facebookSignin.dart';
import 'package:buddies/services/googleLogin.dart';
import 'package:buddies/services/userAuthentication.dart';
import 'package:buddies/widgets/button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FacebookLogin fbLogin = new FacebookLogin();
  bool isFacebookLoginIn = false;
  String errorMessage = '';
  String successMessage = '';

  final _phoneController = TextEditingController();
  TextEditingController userNameController=TextEditingController();
  Map user;


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
                customButton(buttonName: 'Connect with Facebook',
                    onPressed:(){
                  LoginFacebook(context);
                    } ),
                SizedBox(height: 20,),
                customButton(buttonName: 'Connect with Google',
                    onPressed:(){
                      GoogleLogin(context);
                    })
              ],
            ),
            ),
          ),

    );
  }

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





}


