import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomCoupons extends StatelessWidget {
  CustomCoupons({Key? key ,required this.name,}) : super(key: key);
  String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      child: Container(
        width: 335.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                width: 0.5.w,
                color: AppColors.grey
            )
        ),
        child: Column(
          children: [
            Text(name,
              style: AppFonts.banadoraText.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
