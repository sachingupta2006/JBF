import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.hint,
      this.keyboardType,
      this.maxLength,
      this.textAling});
  final controller;
  final hint;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextAlign? textAling;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAling ?? TextAlign.start,
      maxLength: maxLength,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          counterText: '',
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
