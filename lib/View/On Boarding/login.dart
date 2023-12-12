import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Utils/common_button.dart';
import 'package:jbf/Utils/custom_textformfield.dart';
import 'package:jbf/Utils/sizebox.dart';

import 'verify_otp.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneTEC = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon.jpeg'),
            Text('Phone Verification',
                style: TextStyle(fontWeight: FontWeight.bold)),
            30.h.height,
            CustomTextFormField(
              hint: 'Phone Number',
              textAling: TextAlign.start,
              maxLength: 10,
              controller: phoneTEC,
              keyboardType: TextInputType.number,
              prefix: Text(
                '+91 ',
                style: TextStyle(color: Colors.black),
              ),
            ),
            30.h.height,
            CommonButton(
                ontap: () async {
                  // await FirebaseAuth.instance.verifyPhoneNumber(
                  //   phoneNumber: '+91${phoneTEC.text}',
                  //   verificationCompleted: (PhoneAuthCredential credential) {},
                  //   verificationFailed: (FirebaseAuthException e) {},
                  //   codeSent: (String verificationId, int? resendToken) {},
                  //   codeAutoRetrievalTimeout: (String verificationId) {},
                  // );
                  if (phoneTEC.text.length != 10) {
                    Get.snackbar('Error', 'Please enter correct Phone Number');
                  } else {
                    Get.to(() => VerifyOTP(
                          phoneNumber: phoneTEC.text,
                        ));
                  }
                },
                text: 'Verify OTP'),
          ],
        ),
      ),
    );
  }
}
