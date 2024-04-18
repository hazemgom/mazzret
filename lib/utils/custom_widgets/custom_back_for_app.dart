import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomBackForAppBar extends StatelessWidget {
  Function()? onPressed;
  String text;
  String text2;

  CustomBackForAppBar({
    super.key,
    required this.onPressed,
    required this.text,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      titleTextStyle: AppFonts.styleBold20,
      contentTextStyle: AppFonts.styleRegular20,
      title: Text(
        AppLocalizations.of(context)!.warning,
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
          color: Colors.red,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        text,
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(12.r),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: EdgeInsetsDirectional.only(bottom: 20.h),
      actions: [
        CustomButtonWidget(
          hasElevation: true,
          height: 45.h,
          width: 100.w,
          onPressed: () {
            Navigator.pop(context);
          },
          text: AppLocalizations.of(context)!.cancel,
          fontStyle: AppFonts.snackbarText,
        ),
        CustomButtonWidget(
          hasElevation: true,
          height: 45.h,
          width: 100.w,
          onPressed: onPressed,
          text: text2,
          fontStyle: AppFonts.snackbarText,
        ),
      ],
    );
  }
}
