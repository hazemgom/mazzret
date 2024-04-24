import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CustomCategory extends StatelessWidget {
  CustomCategory(
      {Key? key, required this.image, required this.text, required this.onTap})
      : super(key: key);
  String image;
  String text;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            // ClipRect(
            // child:Image.asset(image) ,
            // ),
            // CachedImage(link: image, width: 82.w, height: 80.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                errorWidget: (context, url, error) {
                  return SvgPicture.asset(AppAssets.emptyImage);
                },
                imageUrl: image,
                width: 92.w,
                height: 90.h,
                fit: BoxFit.cover,
              ),
            ),
            //     : Container(
            //   width: width ?? 30,
            //   height: height ?? 30,
            //   decoration: BoxDecoration(
            //     color: AppColors.primaryColor,
            //     shape: BoxShape.circle,
            //   ),
            //   padding: const EdgeInsets.all(8),
            // ),
            SizedBox(
                width: 80.w,
                height: 47.h,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    // overflow: TextOverflow.clip,
                  ),
                  // style: AppFonts.categoryTitle,
                ))
          ],
        ),
      ),
    );
  }
}
