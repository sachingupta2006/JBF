import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    GlobalKey<FormState>? form,
    this.ontap,
    required this.text,
    this.colorchange = false,
    this.size,
  }) : super(key: key);

  final bool colorchange;
  final GestureTapCallback? ontap;
  final String text;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 60.h,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              shadowColor: const Color.fromARGB(255, 220, 220, 226),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              ontap!();
            },
            child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: size ?? 18))));
  }
}

class CommonButtonGrey extends StatelessWidget {
  const CommonButtonGrey({
    Key? key,
    GlobalKey<FormState>? form,
    this.ontap,
    required this.text,
    this.colorchange = false,
    this.size,
  }) : super(key: key);

  final bool colorchange;
  final GestureTapCallback? ontap;
  final String text;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          shadowColor: const Color.fromARGB(255, 220, 220, 226),
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          ontap!();
        },
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: size ?? 18.sp),
        ),
      ),
    );
  }
}
