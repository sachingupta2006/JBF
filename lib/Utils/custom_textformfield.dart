import 'package:flutter/material.dart';

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
    return TextFormField(
      textAlign: textAling ?? TextAlign.start,
      maxLength: maxLength,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          prefix: prefix,
          counterText: '',
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
