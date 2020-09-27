import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
showToast(BuildContext context,String toastText) {
  FToast fToast;
  fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.grey[500],
    ),
    child: Text("${toastText}",style: TextStyle(color: Colors.white),),
  );


  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );

  // Custom Toast Position
//  fToast.showToast(
//      child: toast,
//      toastDuration: Duration(seconds: 2),
//      positionedToastBuilder: (context, child) {
//        return Positioned(
//          child: child,
//          top: 16.0,
//          left: 16.0,
//        );
//      });
}
