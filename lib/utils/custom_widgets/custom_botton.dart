import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    this.onPressed,
    this.color,
    this.text,
    this.textColor = Colors.white,
    this.height,
    this.width,
    this.child,
    this.borderColor,
    this.hasElevation = false,
    this.loading = false,
    this.loadingColor,
    this.borderRadius = 24,
    this.fontStyle,
    this.margin,
    this.onButtonPressed,
  }) : assert(child != null || text != null);
  final Function()? onPressed;
  final Color? color;
  final String? text;
  final double? height;
  final double? width;
  final Widget? child;
  final Color? borderColor;
  final Color textColor;
  final bool hasElevation;
  final bool loading;
  final Color? loadingColor;
  final double borderRadius;
  final TextStyle? fontStyle;
  final EdgeInsetsGeometry? margin;
  final Function(String?)? onButtonPressed;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(10.sp),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: AppColors.primaryColor,
        ),
        child: Center(
          child: Text(
            text!,
            style: GoogleFonts.cairo(
              color: AppColors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
