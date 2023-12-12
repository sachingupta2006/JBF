import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Utils/common_button.dart';
import 'package:jbf/Utils/custom_textformfield.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/View/Bottom%20Bar/bottombar.dart';

class VerifyOTP extends StatelessWidget {
  const VerifyOTP({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    TextEditingController pwTEC = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon.jpeg'),
            Text('OTP Verification send on $phoneNumber',
                style: TextStyle(fontWeight: FontWeight.w600)),
            30.h.height,
            CustomTextFormField(
              hint: 'OTP',
              textAling: TextAlign.center,
              maxLength: 10,
              controller: pwTEC,
              keyboardType: TextInputType.number,
            ),
            30.h.height,
            CommonButton(
                ontap: () async {
                  if (pwTEC.text.length != 10) {
                    Get.snackbar('Error', 'Please enter correct OTP');
                  } else {
                    Get.to(() => CustomBottomBar());
                  }
                },
                text: 'Verify OTP'),
          ],
        ),
      ),
    );
  }
}
