import 'package:buddies/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:buddies/screens/interestsScreen.dart';
class FormScreen extends StatefulWidget {
  String name;
  FirebaseUser user;
  FormScreen({this.name,this.user}){
    print(user);
  }
  @override
  State<StatefulWidget> createState() {
    return FormScreenState(name: name,user:user);
  }
}

class FormScreenState extends State<FormScreen> {
  String name;
  FirebaseUser user;
  FormScreenState({this.name,this.user}){
    _name=name;
    if(user!=null)
      _email=user.email;
  }

  String _name;
  String _email;
  String _gender;
  String _institute;
  String _class;
  String _dob;
  String _about;
  bool _isChecked = true;
  String _currText = '';
  List<String> _checked= [];


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildgender() {
    return Row(
      children: <Widget>[
        CheckboxGroup(
          orientation: GroupedButtonsOrientation.HORIZONTAL,
          margin: const EdgeInsets.only(left: 12.0),
          onSelected: (List selected) => setState((){
            try{
            _checked[0] = selected[1??0];}
            catch(e){
              print(e);
              _checked=selected;
            }
            finally{
              _gender=_checked[0]??null;
            }

          }),
          labels: <String>[
"Male","Female","Other"
          ],
          checked: _checked,
          itemBuilder: (Checkbox cb, Text txt, int i){
//              if(_checked.length>0)
//                setState(() {
//                  _checked.clear();
//                });


            print(_checked);
            return Row(
              children: <Widget>[

                cb,
                txt,
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      initialValue: user?.email??null,
      enabled: (user==null)?true:false,
      decoration: InputDecoration(labelText: 'Email',labelStyle: TextStyle(fontSize: 14)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }


  Widget _buildDateofBirth() {
    return TextFormField(
      keyboardType: TextInputType.datetime,

      decoration: InputDecoration(labelText: 'Date of Birth',hintText: "DD/MM/YYYY",hintStyle: TextStyle(fontSize: 14),labelStyle: TextStyle(fontSize: 14)),



      onSaved: (String value) {
        _dob = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone number',labelStyle: TextStyle(fontSize: 14)),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onSaved: (String value) {
       // _url = value;
      },
    );
  }

  Widget _buildInstitute() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'School/College',labelStyle: TextStyle(fontSize: 14)),


      onSaved: (String value) {
        _institute = value;
      },
    );
  }
  Widget _buildClass() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Major/Class',labelStyle: TextStyle(fontSize: 14)),


      onSaved: (String value) {
        _class = value;
      },
    );
  }
  Widget _buildAbout() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'A Little about yourself',labelStyle: TextStyle(fontSize: 14)),


      onSaved: (String value) {
        _about = value;
      },
    );
  }
  var firedb;
  CollectionReference firedb2;
@override
  void initState() {
   firedb=Firestore.instance.collection('users').snapshots();
   firedb2=Firestore.instance.collection('users');
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:StreamBuilder(
        stream: firedb,
        builder: (context,snapshot){
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          return Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 30,left: 10,right: 10),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Column(

                  children: <Widget>[
                    _buildEmail(),
                    SizedBox(height: 10,),
                    _buildgender() ,
                    SizedBox(height: 20,),
                    _buildDateofBirth(),
                    SizedBox(height: 10,),
                    _buildInstitute(),
                    SizedBox(height: 10,),
                    _buildClass(),
                    SizedBox(height: 10,),
                    _buildAbout(),
                    SizedBox(height: 50),

                    CustomButton2(context, 'Next', () async{
                      if(_formKey.currentState.validate())
                      {_formKey.currentState.save();
                      await firedb2.add({'Name':_name,
                        'about':_about,
                        'class':_class,
                        'dob':_dob,
                        'email':_email,
                        'gender':_gender,
                        'institution':_institute

                      }).then((value) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InterestsScreen()));});
                    }})

                  ],
                ),
              ],

            ),
          ),
        ),
      );        },
      )

    );
  }


}