import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDetailsCoupons extends StatelessWidget {
   CustomDetailsCoupons({Key? key ,required this.name,required this.expire,required this.discount}) : super(key: key);
  String name;
  String expire;
  String discount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
      child: Container(
        width: 335.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 1.w,
            color: AppColors.grey
          )
        ),
        child: Column(
          children: [
            Text(name,
            style: AppFonts.banadoraText.copyWith(color: AppColors.primaryColor),
            ),
            SizedBox(height: 5.h,),
            Row(
              children: [
                Text("${AppLocalizations.of(context)!.expiration} : ",
                ),
                SizedBox(width: 5.w,),
                Text(expire,
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            Row(
              children: [
                Text("${AppLocalizations.of(context)!.discount} : "),
                SizedBox(width: 5.w,),
                Text(discount,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
