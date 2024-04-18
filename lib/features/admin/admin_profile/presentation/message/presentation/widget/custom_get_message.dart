import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomGetMessage extends StatelessWidget {
  CustomGetMessage({
    Key? key,
    this.email,
    this.phone,
    this.address,
    required this.name,
    required this.message,
    required this.createdIn,
  }) : super(key: key);
  String name;
  String? email;
  String? phone;
  String? address;
  String message;
  String createdIn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: Container(
        width: 335.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 1.w,
            color: AppColors.primaryColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${AppLocalizations.of(context)!.name}: ',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  name,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            email == null
                ? Container()
                :  Row(
              children: [
                Text(
                  '${AppLocalizations.of(context)!.email}: ',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                Expanded(
                  child: Text(
                    email!,
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            phone == null
                ? Container()
                : Row(
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.phonenumber}: ',
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          phone!,
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
            address == null
                ? Container()
                : Row(
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.address}: ',
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          address!,
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Divider(
                thickness: 1.w,
              ),
            ),
            Row(
              children: [
                Text(
                  '${AppLocalizations.of(context)!.message}: ',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  message,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '${AppLocalizations.of(context)!.createdate}: ',
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  createdIn,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
