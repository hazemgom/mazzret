import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CheckPhoneOrEmail extends StatelessWidget {
  const CheckPhoneOrEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.checkPhoneOrEmail,
          style: AppFonts.titleScreen.copyWith(height: 0, fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Text(
              '${AppLocalizations.of(context)!.chooseTypeSender} :-',
              style: GoogleFonts.cairo(
                height: 1.h,
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 40.w,
                right: 40.w,
                bottom: 50.h,
                top: 100.h,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.forgetPasswordByEmailRoute,
                  );
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(8.r),
                  color: AppColors.primaryColor,
                  child: Container(
                    width: double.infinity,
                    height: 100.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey.withOpacity(0.01),
                          offset: const Offset(1, 1),
                          blurRadius: 10.r,
                          spreadRadius: 0.1.r,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.email,
                          style: GoogleFonts.cairo(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            height: 1.h,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18.sp,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 40.w,
                right: 40.w,
                bottom: 20.h,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.forgetPasswordByPhoneRoute,
                  );
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(8.r),
                  color: AppColors.primaryColor,
                  child: Container(
                    width: double.infinity,
                    height: 100.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey.withOpacity(0.01),
                          offset: const Offset(1, 1),
                          blurRadius: 10.r,
                          spreadRadius: 0.1.r,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.phonenumber,
                          style: GoogleFonts.cairo(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            height: 1.h,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18.sp,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
