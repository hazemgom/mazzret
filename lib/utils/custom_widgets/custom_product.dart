import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

import '../../features/home_layout/home/data/models/product_model.dart';
import '../../features/home_layout/home/managers/home_cubit.dart';

class CustomProduct extends StatefulWidget {
  const CustomProduct({
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
  State<CustomProduct> createState() => _CustomProductState();
}

class _CustomProductState extends State<CustomProduct> {
  bool isOpen = false;
  bool isLoading = false;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        10.w,
      ),
      child: Stack(
        children: [
          Container(
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
          if (widget.model != null)
            Positioned(
              bottom: 0.h,
              right: 10.w,
              child: Row(
                children: [
                  if (isOpen)
                    InkWell(
                      onTap: () {
                        isLoading = true;
                        widget.cubit!
                            .addToCart(
                          productId: widget.model!.id!,
                          quantity: count,
                        )
                            .then((value) {
                          isLoading = false;
                        });
                        setState(() {});
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 10,
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : Icon(
                                size: 14,
                                Icons.add_shopping_cart_outlined,
                                color: AppColors.blue,
                              ),
                      ),
                    ),
                  if (isOpen) SizedBox(width: 5.w),
                  if (isOpen)
                    InkWell(
                      onTap: isLoading
                          ? null
                          : () {
                              if (count > 0) {
                                count--;
                              }
                              if (count == 0) {
                                isOpen = false;
                              }
                              setState(() {});
                            },
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        minRadius: 10.r,
                        child: Icon(
                          Icons.remove,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  if (isOpen) SizedBox(width: 5.w),
                  if (isOpen)
                    Text(
                      count.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  if (isOpen) SizedBox(width: 5.w),
                  InkWell(
                    onTap: isLoading
                        ? null
                        : () {
                            isOpen = true;
                            if (count <= widget.model!.quantity!) {
                              count++;
                            }

                            setState(() {});
                          },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      minRadius: 10,
                      child: Icon(
                        Icons.add,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
