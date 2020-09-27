import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
Widget CustomButton2(BuildContext context,String name,onPressed)
{
  return Center(
    child: InkWell(
//      splashColor: Colors.black.withOpacity(1),
//      highlightColor: Colors.black.withOpacity(1),
//      focusColor: Colors.black.withOpacity(1),
//      hoverColor: Colors.black.withOpacity(1),
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.zero,
        width:MediaQuery.of(context).size.width*0.30,
        height: 35,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('lib/images/Button.png'),fit: BoxFit.cover),


        ),
        child: Center(child: Text(name,style: TextStyle(color: Colors.white,fontSize: 20),)),
      ),
    ),
  );
}