import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CustomReview extends StatelessWidget {
   CustomReview({Key? key,required this.image,required this.nameOfProducr,required this.rating}) : super(key: key);
     String image;
     String nameOfProducr;
     int rating;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 0.2.w,
            color: AppColors.grey2
          )
        ),
        child: Column(
          children: [
            Image.asset(image),
            Row(
              children: [
                Text("${AppLocalizations.of(context)!.name} : "),
                SizedBox(width: 5.w,),
                Text(nameOfProducr,
                  style: AppFonts.bodyText,
                ),
              ],
            ),
            Row(
              children: [
                Text("${AppLocalizations.of(context)!.review} : "),
                SizedBox(width: 5.w,),
                Text("$rating",
                style: AppFonts.bodyText,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
