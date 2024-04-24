import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CustomGetUser extends StatelessWidget {
  CustomGetUser({
    Key? key,
    required this.name,
    required this.phone,
    required this.onTap,
  }) : super(key: key);
  String name;
  String phone;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: AppColors.primaryColor,
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.profileIcon,
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.cairo(
                        fontSize: 16.8.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      phone,
                      style: AppFonts.greyText,
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primaryColor,
                  size: 18.sp,
                )
              ],
            ),
          ),
          Divider(
            thickness: 1.w,
          ),
        ],
      ),
    );
  }
}
