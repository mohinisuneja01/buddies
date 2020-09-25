import 'package:buddies/tinderui/tabs/index.dart';
import 'package:buddies/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class InterestsScreen extends StatefulWidget {
  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  TextEditingController categoryController=TextEditingController();
  List<String> categoryList=['Sports','Science','Technology','Literature'];
  List<List<int>> imagelistList=[[1,6,7,1,6,7],[8,9,3,8,9,3],[13,12,11,13,12,11],[13,14,15,13,14,15]];
  String category;
  List<String>  selected=[];
TextEditingController text=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20,),
          Center(child: Text('Pick at least 5 area of interests',style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.bold,fontSize: 18),)),
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding:EdgeInsets.only(top:20),itemCount: 4,itemBuilder:(context,int index){
              return CustomCatgoryImageRow(categoryList[index],imagelistList[index]);
            } ,),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text('Add your own topics of interest',style: TextStyle(color: Colors.grey[500],fontSize: 18),),
        ),
          Container(
            padding: const EdgeInsets.only(left: 25,right: 50,top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            child: TextField(
              controller: categoryController,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                fillColor: Colors.grey[300],
                filled: true,
                hintText: 'Type in any topic you like',
                hoverColor: Colors.grey[500],
                hintStyle: TextStyle(color: Colors.grey[450 ]),
                contentPadding: EdgeInsets.only(top: 13,bottom: 5,left: 13),
                suffixIcon: IconButton(padding:EdgeInsets.zero,icon:Icon(Icons.add),onPressed:(){
                  setState(() {
                    if(categoryController.text!=null)
                    selected.add(categoryController.text);
                    categoryController.clear();
                  });
                } ,),

              ),
            ),
          ),
          SizedBox(height: 10,),
          Column(
            children: <Widget>[
              ListView.builder(itemCount:selected.length,
                  padding: EdgeInsets.only(left: 25),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder:(context,int index){
                return Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text('${selected[index]}',style: TextStyle(color: Colors.grey[700],decoration: TextDecoration.underline,fontSize: 15),),
                );
              } ),
            ],
          )
          ,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: CustomButton2(context, "Finish", (){
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Index()),
                        (Route<dynamic> route) => false,
                  );
                }),
              ),

            ],
          ),
          SizedBox(height: 10,)

        ],
      ),
    );
  }

Widget CustomCard(String image,String category){

    return Container(
padding: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(15)
      ),
      //height: 100,
width: MediaQuery.of(context).size.width*0.3,
child:InkWell(
  onTap: (){
    setState(() {
      if(selected.contains(category)==true)
        selected.remove(category);
      else
      selected.add(category);
    });
  },
  highlightColor: Colors.black,
  child: Container(
    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(image),fit: BoxFit.cover),
    borderRadius: BorderRadius.circular(15)),

  ),
) ,

    );
}

Widget CustomCategory(String text){

}
Widget CustomCatgoryImageRow(String categoryName,List<int> imagePath){
    return
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(top:25,left:27),
              child: Text(categoryName,style: TextStyle(color: Colors.grey[500]),),
            ),
            Container(
              height: 95,
              child: ListView.builder(

                  padding: EdgeInsets.only(left: 25),scrollDirection:Axis.horizontal,itemCount: imagePath.length,itemBuilder:(context,int index){
                return CustomCard('lib/images/IMG '+'${imagePath[index]}'+'.png',categoryName);
              } ),
            ),
          ],
        );

}
}

