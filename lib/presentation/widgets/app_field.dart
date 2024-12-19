import 'package:flutter/material.dart';
import 'package:penny/utils/constants.dart';

class AppField extends StatelessWidget {
  const AppField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType,
  });

  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        color: AppColors.secondary,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.secondary.withValues(alpha: .6)),
        filled: true,
        fillColor: AppColors.tertiary,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none, // Menghilangkan border
        ),
      ),
    );
  }
}
