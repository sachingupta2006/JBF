import 'package:firebase_auth/firebase_auth.dart';
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
    var loginLoader = false.obs;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            50.h.height,
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
            Obx(
              () => loginLoader.value
                  ? const Center(child: CircularProgressIndicator())
                  : CommonButton(
                      ontap: () async {
                        loginLoader.value = true;
                        try {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException ex) {
                                Get.snackbar('Verification Failed', ex.code);
                                loginLoader.value = false;
                              },
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                Get.to(() => VerifyOTP(
                                    phoneNumber: '+91${phoneTEC.text}',
                                    verificationId: verificationId));
                                loginLoader.value = false;
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {
                                loginLoader.value = false;
                              },
                              phoneNumber: '+91${phoneTEC.text}');
                        } catch (e) {
                          loginLoader.value = false;
                          Get.snackbar(
                              'Error during phone verification', e.toString());
                        }
                      },
                      text: 'Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
