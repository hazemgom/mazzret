import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CustomTextFormFieldConnectUs extends StatelessWidget {
  CustomTextFormFieldConnectUs({
    Key? key,
    required this.controller,
    this.label = " ",
    required this.maxLines,
    required this.validator,
  }) : super(key: key);
  TextEditingController controller;
  String label;
  int maxLines;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: AppFonts.bodyText.copyWith(fontSize: 14.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide:
              BorderSide(width: 0.01.w, color: AppColors.grey.withOpacity(0.2)),
        ),
      ),
    );
  }
}
