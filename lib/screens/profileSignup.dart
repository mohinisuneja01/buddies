
import 'package:buddies/screens/userDetail.dart';
import 'package:buddies/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileSignup extends StatefulWidget {
  @override
  _ProfileSignupState createState() => _ProfileSignupState();
}
class _ProfileSignupState extends State<ProfileSignup> {
  var _nameController=TextEditingController();
  _ProfileSignupState(){
  }
  File imageFile1,imageFile2,imageFile3,imageFile4,imageFile5;
  _fromGallery(BuildContext context,int index)async{
    Navigator.of(context).pop();
    var picture=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      switch(index){
        case 1:{
          imageFile1=picture;
        }
        break;
        case 2:{
          imageFile2=picture;
        }
        break;
        case 3:{
          imageFile3=picture;
        }
        break;
        case 4:{
          imageFile4=picture;
        }
        break;
        case 5:{
          imageFile5=picture;
        }
        break;
      }
    });
    Navigator.of(context).pop(context);
  }
  _fromCamera(BuildContext context,int index)async{
    Navigator.of(context).pop();
    var picture=await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      switch(index){
        case 1:{
          imageFile1=picture;
        }
        break;
        case 2:{
          imageFile2=picture;
        }
        break;
        case 3:{
          imageFile3=picture;
        }
        break;
        case 4:{
          imageFile4=picture;
        }
        break;
        case 5:{
          imageFile5=picture;
        }
        break;
      }
    });
    Navigator.of(context).pop(context);
  }


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
                image: AssetImage('lib/images/bg3.png',), fit: BoxFit.cover
            ),
          ),
          child:
          Scaffold(
            backgroundColor: Colors.white.withOpacity(0),
            resizeToAvoidBottomPadding:true ,
            body: ListView(
              padding: EdgeInsets.zero,
              children: [
                Column(
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
                          child:(imageFile1==null)?
                          Center(
                            child: IconButton(icon:Image.asset('lib/images/PlusIcon.png',) ,onPressed:()=> _showDialog(context,1),iconSize: 150,),
                          ): InkWell(onTap:()=>_showDialog(context,1 ),child: Image.file(imageFile1,fit: BoxFit.cover,))
                        //Image.file(image.elementAt(0),fit:BoxFit.cover,)
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ImageCard(2),
                        ImageCard(3),
                        ImageCard(4),
                        ImageCard(5),

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
                )   ],

            ),
          ),

        ),
      ),);


  }
  Widget ImageCard(int index){
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 5,
      child: Container(
        child:InkWell(child: imageReturn(index),onTap:(){ _showDialog(context,index);},),
        height: 80,
        width: MediaQuery.of(context).size.width*0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white
        ),
      ),
    );
  }


  Future toFormScreen() async{
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FormScreen(name: _nameController.text)));
  }


  _showDialog(BuildContext context,int index){
    return showDialog(

      barrierDismissible:true,context: context,builder: (context)=>
        AlertDialog(
          //contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Choose',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,),),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(icon:Image.asset('lib/images/camera.png'),iconSize: 25,onPressed:(){_fromCamera(context,index);},),
                        ),
                        Text('Camera')
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: IconButton(icon:Image.asset('lib/images/gallery.png'),iconSize: 25,onPressed:(){_fromGallery(context,index);},),
                        ),
                        Text('Gallery')

                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
  Widget imageReturn(int index)
  {
    switch(index)
    {
      case 2:{
        return (imageFile2!=null)?Image.file(imageFile2,fit: BoxFit.cover,):null;
      }
      break;
      case 3:{
        return (imageFile3!=null)?Image.file(imageFile3,fit: BoxFit.cover,):null;
      }
      break;
      case 4:{
        return (imageFile4!=null)?Image.file(imageFile4,fit: BoxFit.cover,):null;
      }
      break;
      case 5:{
        return (imageFile5!=null)?Image.file(imageFile5,fit: BoxFit.cover,):null;
      }
      break;
      default: null;
    }
  }

}

