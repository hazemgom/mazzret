import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: CircularProgressIndicator(
        backgroundColor: AppColors.grey.withOpacity(0.5),
        color: AppColors.primaryColor.withOpacity(0.6),
      ),
    );
  }
}
