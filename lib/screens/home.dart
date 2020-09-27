import 'package:buddies/tinderui/scr/hookup.dart';
import 'package:buddies/tinderui/tabs/index.dart';
import 'package:buddies/tinderui/tabs/settings_tab/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:buddies/screens/homescreenNavBarWidgets/Chat.dart';
import 'package:buddies/screens/homescreenNavBarWidgets/Notification.dart';
import 'package:buddies/screens/homescreenNavBarWidgets/HomeBody.dart';
import 'package:buddies/screens/homescreenNavBarWidgets/Settings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 static List<Widget> Screens=[
  HomeBody(),
   Chat(),
   HookUp(),
   Notifications(),
   Settings()

 ];
 int _currentItem=2;
 String _title;

 void _onItemTapped(int index) {
   setState(() {
     print(index);
     _currentItem = index;
   });

 }

 @override
  Widget build(BuildContext context) {





    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentItem,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF87E6D5),
        items: [
          BottomNavigationBarItem(icon: Image.asset((_currentItem==0)?'lib/images/highlight1.png':'lib/images/dim1.png',height: 25,),title: Text(''),),
          BottomNavigationBarItem(icon: Image.asset((_currentItem==1)?'lib/images/highlight2.png':'lib/images/dim2.png',height: 25),title: Text('')),
          BottomNavigationBarItem(icon:Image.asset((_currentItem==2)?'lib/images/highlight3.png':'lib/images/dim3.png',height: 25),title: Text('')),
          BottomNavigationBarItem(icon:Image.asset((_currentItem==3)?'lib/images/highlight4.png':'lib/images/dim4.png',height: 25),title: Text('')),
          BottomNavigationBarItem(icon:Image.asset((_currentItem==4)?'lib/images/highlight5.png':'lib/images/dim5.png',height: 25,),title: Text('')),

        ],
        onTap: _onItemTapped

    ) ,
//

      body: Container(
        color: Colors.white70,
        height:MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
       child: Column(
         children: <Widget>[
           Padding(
             padding: const EdgeInsets.only(top:20.0,left: 3),
             child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                 IconButton(icon: Icon(Icons.arrow_back_ios,size: 17,),onPressed: null,),
                 Container(
                   height: 20,
                   width: MediaQuery.of(context).size.width*0.05,
                   // constraints: BoxConstraints.expand(),
                   decoration: BoxDecoration(image: DecorationImage(image: AssetImage('lib/images/icon.png'),fit: BoxFit.cover),
                   ),
                 ),
                 SizedBox(width: 10,),
                 Container(
                   height: 20,
                   width: MediaQuery.of(context).size.width*0.25,
                   // constraints: BoxConstraints.expand(),
                   decoration: BoxDecoration(image: DecorationImage(image: AssetImage('lib/images/buddies.png'),fit: BoxFit.cover),
                   ),
                 ),
                 SizedBox(width: MediaQuery.of(context).size.width*0.3,),
                // IconButton(icon: FaIcon(FontAwesomeIcons.solidUserCircle,size: 17,),onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingsTab())),),

               ],
             ),
           ),
           Container(
             height: MediaQuery.of(context).size.height*0.79,
             width:  MediaQuery.of(context).size.width,
             child: Screens[_currentItem],
           ),

         ],
       ),

)
    );
  }


}
