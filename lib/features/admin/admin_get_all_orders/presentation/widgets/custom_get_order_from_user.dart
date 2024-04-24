import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CustomGetOrderFromUser extends StatelessWidget {
  CustomGetOrderFromUser({
    Key? key,
    required this.name,
    required this.phone,
    required this.state,
    required this.onTap,
    required this.onTapInConfirm,
    required this.confirmColor,
    required this.buttonText,
    required this.id,
    required this.orderNumber,
    required this.date,
  }) : super(key: key);
  String name;
  String phone;
  String state;
  String buttonText;
  String id;
  String date;
  int orderNumber;
  Color confirmColor;
  void Function()? onTap;
  void Function()? onTapInConfirm;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                width: 1.w,
                color: AppColors.grey,
              )),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.order,
                      style: AppFonts.primarytext.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                      ),
                    ),
                    InkWell(
                      onTap: onTapInConfirm,
                      child: Text(
                        buttonText,
                        style: AppFonts.primarytext.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                          color: confirmColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.5.w,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.ordernumberr}: $id',
                          style: GoogleFonts.cairo(
                              color: AppColors.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Text(
                      date,
                      style: GoogleFonts.cairo(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.5.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.name}: ',
                              style: GoogleFonts.cairo(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                name,
                                style: GoogleFonts.cairo(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        Row(
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.phonenumber}: ',
                              style: GoogleFonts.cairo(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                phone,
                                style: GoogleFonts.cairo(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        Row(
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.status}: ',
                              style: GoogleFonts.cairo(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                state,
                                style: GoogleFonts.cairo(
                                  fontSize: 16.sp,
                                  color: confirmColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      AppAssets.orderIcon,
                      width: 40.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
