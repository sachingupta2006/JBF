import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:jbf/Utils/common_button.dart';
import 'package:jbf/Utils/sizebox.dart';

class NewBill extends StatelessWidget {
  const NewBill({super.key, required this.image});
  final Uint8List image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Bill'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.memory(image),
            20.h.height,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonButton(
                  ontap: () async {
                    await FlutterShare.share(
                        title: 'tittle',
                        text: 'JBF bill',
                        linkUrl: 'https://',
                        chooserTitle: 'Example Chooser Title');
                  },
                  text: 'Share'),
            )
          ],
        ),
      ),
    );
  }
}
