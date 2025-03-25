import 'package:flutter/material.dart';
import 'package:assesment_5d/constants/app_colors.dart';

class RoundedTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;
  final Widget? suffixIcon;

  const RoundedTextfield({
    super.key,
    this.hintText = '',
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.primaryOrange,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        maxLines: maxLines,
        maxLength: maxLength,
        style: TextStyle(color: AppColors.darkGray),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.lightGray),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: AppColors.lightGray)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: AppColors.primaryOrange)),
          suffixIcon: suffixIcon,
          // counterText: '',
        ),
      ),
    );
  }
}