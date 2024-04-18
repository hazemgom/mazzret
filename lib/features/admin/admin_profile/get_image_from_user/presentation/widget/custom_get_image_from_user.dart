import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomGetImageFromUser extends StatelessWidget {
  CustomGetImageFromUser(
      {Key? key,
      required this.image,
      required this.nameOfuser,
      required this.emailOfuser,
      required this.phoneOfProduct,
      required this.createdIn,
      required this.nameOfProduct})
      : super(key: key);
  String nameOfProduct;
  String nameOfuser;
  String image;
  String emailOfuser;
  String phoneOfProduct;
  String createdIn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        width: 335.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(width: 1.w, color: AppColors.primaryColor)),
        child: Column(
          children: [
            // Image.asset(image),
            CachedImage(
              link: image,
              borderRadius: 14.r,
              width: 99.w,
              height: 75.h,
            ),
            Row(
              children: [
                Text(
                  "${AppLocalizations.of(context)!.name} : ",
                  style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontSize: 16.8.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  nameOfuser,
                  style: GoogleFonts.cairo(
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Text(
                  "${AppLocalizations.of(context)!.email} : ",
                  style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontSize: 16.8.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  emailOfuser,
                  style: GoogleFonts.cairo(
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),

            Row(
              children: [
                Text(
                  "${AppLocalizations.of(context)!.phonenumber} : ",
                  style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontSize: 16.8.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  phoneOfProduct,
                  style: GoogleFonts.cairo(
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),

            Row(
              children: [
                Text("${AppLocalizations.of(context)!.product} : ", style: GoogleFonts.cairo(
                  color: Colors.black,
                  fontSize: 16.8.sp,
                  fontWeight: FontWeight.w600,
                ),),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  nameOfProduct,
                  style: GoogleFonts.cairo(
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "${AppLocalizations.of(context)!.createdate} : ",
                  style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontSize: 16.8.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  createdIn,
                  style: GoogleFonts.cairo(
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
