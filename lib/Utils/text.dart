import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget text15BlackBold(String txt) {
  return Text(txt,
      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold));
}

Widget text15BlackBoldCenter(String txt) {
  return Text(txt,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold));
}

Widget text15Black(String txt) {
  return Text(txt, style: TextStyle(fontSize: 15.sp));
}

Widget text12Black(String txt) {
  return Text(txt, style: TextStyle(fontSize: 12.sp));
}

Widget text12BlackBold(String txt) {
  return Text(txt,
      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold));
}

Widget text6Black(String txt) {
  return Text(txt, style: TextStyle(fontSize: 6.sp));
}

Widget text8Black(String txt) {
  return Text(txt, style: TextStyle(fontSize: 8.sp));
}

Widget text10Black(String txt) {
  return Text(txt, style: TextStyle(fontSize: 10.sp));
}
