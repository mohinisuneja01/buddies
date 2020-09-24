
import 'package:buddies/services/facebookLogin.dart';
import 'package:buddies/services/userAuthentication.dart';
import 'package:buddies/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code.dart';
import '';
class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  final _phoneController = TextEditingController();
  TextEditingController userNameController=TextEditingController();
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
                customButton(buttonName: 'Connect with Facebook',onPressed:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Facebook())) ),
                SizedBox(height: 20,),
                customButton(buttonName: 'Connect with Google',onPressed: (){print("Login with facebook");})
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
  _ShowFormInDialog(BuildContext context) {
    var firestoreDb = Firestore.instance.collection('user');


    return showDialog(

        context: context, barrierDismissible: true, builder: (param) =>
        AlertDialog(
          actions: <Widget>[
            RaisedButton(
              child: Text("Save"),
              onPressed: () async {
                if(userNameController.text!=null)
                  await  firestoreDb.document().setData({'Questions':{'${userNameController.text}':List()}},merge:true);
//                  await  firestoreDb.document(name).setData({'Questions':[{'${subjectDetailController.text}':[]}]},merge:true);
                userNameController.clear();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("cancel"),
              onPressed: () {
                userNameController.clear();
                Navigator.of(context).pop();
              },
            )
          ],
          title: Text("Add Question"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    labelText: "Question",
                  ),
                ),
              ],
            ),
          ),
        ));
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

