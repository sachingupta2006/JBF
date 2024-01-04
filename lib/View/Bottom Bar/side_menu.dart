import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbf/Utils/text.dart';

Widget drawerCustom(context) {
  return SafeArea(
      child: Container(
          width: MediaQuery.sizeOf(context).width / 1.5,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              )),
          child: Column(
            children: [
              Text('Konsa Konsa Feater chaiye batao'),
              Divider(thickness: 1.w),
              ElevatedButton(
                  onPressed: () {
                  },
                  child: text10Black('chats'))
            ],
          )));
}
