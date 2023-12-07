import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jbf/Utils/common_button.dart';
import 'package:jbf/Utils/custom_textformfield.dart';
import 'package:jbf/Utils/sizebox.dart';
import 'package:jbf/View/Bottom%20Bar/bottombar.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController pwTEC = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            250.h.height,
            CustomTextFormField(textAling: TextAlign.center,
              maxLength: 4,
              controller: pwTEC,
              keyboardType: TextInputType.number,
            ),
            30.h.height,
            CommonButton(
                ontap: () {
                  if (pwTEC.text != '0000') {
                    Get.snackbar(
                        'Wrong Password', 'Please enter correct password');
                  } else {
                    Get.to(() => CustomBottomBar());
                  }
                },
                text: 'Login'),
          ],
        ),
      ),
    );
  }
}
