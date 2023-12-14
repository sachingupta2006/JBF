import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.hint,
      this.keyboardType,
      this.maxLength,
      this.textAling,
      this.prefix});
  final controller;
  final hint;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextAlign? textAling;
  final Widget? prefix;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        textAlign: textAling ?? TextAlign.start,
        maxLength: maxLength,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefix: prefix,
          counterText: '',
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
        ),
      ),
    );
  }
}
