import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
Widget CustomButton2(BuildContext context,String name,onPressed)
{
  return Center(
    child: Container(
      width:MediaQuery.of(context).size.width*0.3,
      height: 40,
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage('lib/images/Button.png'),fit: BoxFit.cover),

      ),
      child: Center(child: InkWell(
          onTap: onPressed,child: Text(name,style: TextStyle(color: Colors.white,fontSize: 20),))),
    ),
  );
}