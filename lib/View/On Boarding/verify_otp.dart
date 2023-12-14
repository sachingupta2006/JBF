import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Utils/common_button.dart';
import 'package:jbf/Utils/custom_textformfield.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/View/Bottom%20Bar/bottombar.dart';

class VerifyOTP extends StatelessWidget {
  const VerifyOTP(
      {super.key, required this.phoneNumber, required this.verificationId});
  final String phoneNumber;
  final String verificationId;
  @override
  Widget build(BuildContext context) {
    TextEditingController pwTEC = TextEditingController();
    var loadingBool = false.obs;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon.jpeg'),
            Text('OTP Verification code send on $phoneNumber',
                style: TextStyle(fontWeight: FontWeight.w600)),
            30.h.height,
            CustomTextFormField(
                hint: 'OTP',
                textAling: TextAlign.center,
                maxLength: 10,
                controller: pwTEC,
                keyboardType: TextInputType.number),
            30.h.height,
            Obx(
              () => loadingBool.value
                  ? const Center(child: CircularProgressIndicator())
                  : CommonButton(
                      ontap: () async {
                        loadingBool.value = true;
                        try {
                          PhoneAuthCredential credential =
                              await PhoneAuthProvider.credential(
                                  verificationId: verificationId,
                                  smsCode: pwTEC.text.toString());
                          await FirebaseAuth.instance
                              .signInWithCredential(credential)
                              .then((value) {
                            Get.to(() => CustomBottomBar());
                            Get.snackbar('Success', 'OTP Verified');
                          });
                        } catch (e) {
                          Get.snackbar(
                              'Error during otp verification', e.toString());
                        } finally {
                          loadingBool.value = false;
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
