
import 'package:buddies/screens/userDetail.dart';
import 'package:buddies/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileSignup extends StatefulWidget {

  @override
  _ProfileSignupState createState() => _ProfileSignupState();
}

class _ProfileSignupState extends State<ProfileSignup> {
var _nameController=TextEditingController();
@override
  void initState() {
  var firestoredb=Firestore.instance.collection('users');
    super.initState();
  }
FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.3), BlendMode.dstATop),
                image: AssetImage('lib/images/BG3.png',), fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40,),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                height: 50,
                child: Center(child: Text('Put your best forward',
                  style: TextStyle(fontSize: 23,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.normal),)),

              ),
              SizedBox(height: 15,),
              Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 5,
                child: Container(
                  height: 240,
                  width: MediaQuery.of(context).size.width*0.73,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Center(
child: IconButton(icon:Image.asset('lib/images/PlusIcon.png',) ,onPressed: (){},iconSize: 150,),
                  ),

                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ImageCard(),
                  ImageCard(),
                  ImageCard(),
                  ImageCard(),

                ],
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width*0.60,
                child: TextField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.grey,
                  controller: _nameController,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(

                    //contentPadding: EdgeInsets.only(bottom: 0,left: 13,right: 9),
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder:UnderlineInputBorder (
                        borderSide: BorderSide(color: Colors.black,width:1 )
                    ),
                    focusedBorder: UnderlineInputBorder (
                        borderSide: BorderSide(color: Colors.black,width:1 )
                    ),

                  ),
                ),
              ),
              SizedBox(height: 18,),
              CustomButton2(context, "Next", () async=>toFormScreen())
            ],
          ),
        ),
      ),
    );
  }
  Widget ImageCard(){
    return InkWell(
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 5,
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width*0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white
          ),
        ),
      ),

    );
  }

  Future toFormScreen() async{
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FormScreen()));
    await Firestore.instance.collection('users').add({
      "Name":_nameController
    });

  }
}