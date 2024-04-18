import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CustomTextFormFiled extends StatelessWidget {
  CustomTextFormFiled({
    super.key,
    required this.label,
    this.controller,
    this.suffixIcon,
    this.preffixIcon,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
    this.hintText,
    this.keyboardType,
    this.textDirection,
    this.floatingLabelBehavior,
  });

  String label;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  bool readOnly;
  String? hintText;
  TextInputType? keyboardType;
  TextDirection? textDirection;
  FloatingLabelBehavior? floatingLabelBehavior;

  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
      child: Container(
        // height: 48.h,
        child: TextFormField(
          textDirection: textDirection,
          cursorColor: AppColors.primaryColor,
          readOnly: readOnly,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          style: GoogleFonts.cairo(
             height: 1.4.h,
            fontSize: 18.sp,
          ),
          decoration: InputDecoration(
            floatingLabelBehavior: floatingLabelBehavior,
            floatingLabelStyle: GoogleFonts.cairo(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
            suffixIcon: suffixIcon,
            suffixIconColor: AppColors.primaryColor,
            prefixIconColor: AppColors.primaryColor,
            prefixIcon: preffixIcon,
            label: Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.cairo(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black38
            ),
            labelStyle: AppFonts.bodyText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 1.w, color: AppColors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 1.w, color: AppColors.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
