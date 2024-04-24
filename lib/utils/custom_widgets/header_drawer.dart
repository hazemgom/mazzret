import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';

class HeaderDrawer extends StatelessWidget {
  const HeaderDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      width: double.infinity,
      // height: 200.h,
      constraints: BoxConstraints(
        maxHeight: 250.h,
        minHeight: 220.h,
      ),
      padding: EdgeInsets.only(top: 42.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 46.r,
            backgroundColor: AppColors.white,
            child: CircleAvatar(
              radius: 45.r,
              backgroundColor: AppColors.white,
              child: CircleAvatar(
                radius: 42.r,
                backgroundColor: AppColors.primaryColor,
                child: Icon(
                  Icons.person_2_outlined,
                  color: AppColors.white,
                  size: 25.sp,
                ),
              ),
            ),
          ),
          Text(
            MyCache.getString(key: CacheKeys.fullName).toString(),
            style: GoogleFonts.cairo(color: Colors.white, fontSize: 20.sp),
          ),
          Text(
            MyCache.getString(key: CacheKeys.email).toString(),
            style: GoogleFonts.cairo(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
