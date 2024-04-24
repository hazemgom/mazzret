import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CustomContainerMyOrder extends StatelessWidget {
  CustomContainerMyOrder({
    Key? key,
    required this.text,
    required this.color,
    required this.paymentMethod,
    required this.statusOfOrder,
    required this.statusColor,
    required this.orderNumber,
    required this.id,
    required this.date,
    required this.onTap,
  }) : super(key: key);
  String text;
  String paymentMethod;
  String date;
  String statusOfOrder;
  String id;
  int orderNumber;
  Color statusColor;
  Color color;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Container(
          padding:
              EdgeInsets.only(top: 7.h, bottom: 5.h, left: 16.w, right: 16.w),
          height: 160.h,
          width: 335,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(width: 0.2.w, color: AppColors.grey)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                      // Text(
                      //   id,
                      //   style: GoogleFonts.cairo(
                      //       color: AppColors.primaryColor,
                      //       fontSize: 14.sp,
                      //       fontWeight: FontWeight.w500),
                      // ),
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
              Divider(
                thickness: 0.5.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.ordernumber,
                    style: AppFonts.blackText,
                  ),
                  // SizedBox(
                  //   width: 5.w,
                  // ),
                  // Text( "368",
                  // style: AppFonts.blackText.copyWith(fontWeight: FontWeight.bold),
                  // ),
                  // Spacer(),
                  Text(
                    statusOfOrder,
                    style: GoogleFonts.cairo(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    paymentMethod,
                    style: GoogleFonts.cairo(),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 5.w),
              //       child: SvgPicture.asset(AppAssets.reloadIcon),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 5.h,
              // ),
              Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: GoogleFonts.cairo(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.showproducts,
                          style: GoogleFonts.cairo(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 17.sp,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
