import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/managers/user_cart_cubit.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CustomPreviousAdress extends StatelessWidget {
  String? alias, details, phone, city, postCode;
  void Function()? onTap, onCall;

  CustomPreviousAdress({
    Key? key,
    required this.city,
    required this.phone,
    required this.details,
    required this.alias,
    required this.postCode,
    this.onTap,
    this.onCall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.h, right: 16.w, left: 16.w),
      // height: 190.h,
      width: 335.w,
      decoration: BoxDecoration(
        border: Border.all(width: 0.2.w, color: AppColors.grey),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.orderIcon,
                width: 40.w,
              ),
              const Spacer(),
              Text(
                postCode!,
                style: GoogleFonts.cairo(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              SvgPicture.asset(AppAssets.locationIcon),
              SizedBox(
                width: 10.w,
              ),
              Text(
                AppLocalizations.of(context)!.nameOfMyAddress,
                style: AppFonts.bodyText,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            child: Text(
              city!,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
          ),
          InkWell(
            overlayColor: MaterialStateProperty.all(
              AppColors.primaryColor.withOpacity(0.2),
            ),
            onTap: onCall,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.callIcon,
                      color: AppColors.grey2,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      AppLocalizations.of(context)!.phonenumber,
                      style: AppFonts.bodyText,
                    )
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Text(
                    phone!,
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            overlayColor: MaterialStateProperty.all(
              AppColors.primaryColor.withOpacity(0.2),
            ),
            onTap: onTap,
            child: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.locationIcon,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      AppLocalizations.of(context)!.detailsoflocation,
                      style: AppFonts.bodyText.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Text(
                    details!,
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
