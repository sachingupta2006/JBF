import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:jbf/Utils/common_button.dart';
import 'package:jbf/Utils/sizebox.dart';

class NewBill extends StatelessWidget {
  const NewBill({super.key, required this.image, required this.pdfPath});
  final Uint8List image;
  final String pdfPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Confirm Bill'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Image.memory(image),
          20.h.height,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonButton(
                ontap: () {
                  print('sachin:$pdfPath');
                  FlutterShare.shareFile(title: 'title', filePath: pdfPath);
                },
                text: 'Share'),
          )
        ])));
  }
}
