import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CustomGetAddress extends StatelessWidget {
  CustomGetAddress({
    Key? key,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.onTap,
  }) : super(key: key);
  String address, phone, email, name;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(width: 1.w, color: AppColors.primaryColor),
        ),
        child: Column(
          children: [
            Text(
              name,
              style:
                  AppFonts.banadoraText.copyWith(color: AppColors.primaryColor),
            ),
            Text(
              email,
              style: GoogleFonts.cairo(
                color: Colors.grey[600],
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              phone,
              style: GoogleFonts.cairo(
                color: Colors.grey[600],
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            InkWell(
              overlayColor: MaterialStateProperty.all(
                AppColors.primaryColor.withOpacity(0.2),
              ),
              onTap: onTap,
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.locationIcon,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: Text(address,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.cairo(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        )
                        // AppFonts.titleScreen.copyWith(
                        //   color: AppColors.primaryColor,
                        // ),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
