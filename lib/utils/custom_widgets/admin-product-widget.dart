import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

import '../../features/home_layout/home/data/models/product_model.dart';
import '../../features/home_layout/home/managers/home_cubit.dart';

class CustomProductAdmin extends StatefulWidget {
  const CustomProductAdmin({
    Key? key,
    required this.text1,
    required this.text2,
    this.model,
    this.cubit,
    required this.image,
    this.height = 155,
    this.width = 135,
  }) : super(key: key);
  final String text1;
  final String text2;
  final String image;
  final double height;
  final double width;
  final ProductData? model;
  final HomeCubit? cubit;

  @override
  State<CustomProductAdmin> createState() => _CustomProductState();
}

class _CustomProductState extends State<CustomProductAdmin> {
  bool isOpen = false;
  bool isLoading = false;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        10.w,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        height: widget.height.h,
        width: widget.width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.grey, width: 0.2.w),
        ),
        child: SizedBox(
          width: 140.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedImage(
                link: widget.image,
                borderRadius: 14.r,
                width: 99.w,
                height: 75.h,
                fit: BoxFit.cover,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      widget.text1,
                      style: AppFonts.black2Text,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 130.w,
                    child: Text(
                      widget.text2,
                      style: AppFonts.descInWishList,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
