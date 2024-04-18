import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({super.key, required this.onPressed, required this.borderColor, required this.checkIconWidget, required this.textForCheckBox});

  final VoidCallback onPressed;
  final Color borderColor;
  final Widget checkIconWidget;
  final Widget textForCheckBox;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(overlayColor: MaterialStateProperty.all(AppColors.primaryColor.withOpacity(.2))),
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.h,
            margin: EdgeInsets.all(6.sp),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), border: Border.all(width: 1.w, color: borderColor),),
            child: Center(child: checkIconWidget),
          ),
          SizedBox(width: 12.w),
          textForCheckBox,
        ],
      ),
    );
  }
}
