import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/features/admin/sql_connection/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/data_provider/local/cach_keys.dart';
import '../../features/home_layout/home/data/models/product_model.dart';
import '../../features/home_layout/home/managers/home_cubit.dart';
import '../../features/home_layout/home/presentation/product/presentation/details_product.dart';
import '../../main.dart';
import 'navigation.dart';

class CustomProduct extends StatefulWidget {
  const CustomProduct({
    Key? key,
    required this.text1,
    required this.text2,
    this.model,
    this.cubit,
    required this.image,
    this.height = 160,
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

  void addToCart() async {
    setState(() {
      isLoading = true;
    });
    await widget.cubit!.addToCart(
      productId: widget.model!.id!,
      quantity: count,
    );
    setState(() {
      isLoading = false;
    });
  }





  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
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
                 InkWell(
                   onTap: () {
                     Navigator.push(
                       context,
                       FadePageRoute(
                         builder: (context) => DetailsProduct(
                           productId: widget.model!.id!,
                         ),
                       ),
                     );

                   },
                   child: Column(
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
                     ]
                   ),
                 )
                ],
              ),
            ),
          ),
          if (pref.getString('role') == 'user-normal' ||
              pref.getString('role') == 'user-wholesale')
            if (widget.model != null)
              Positioned(
                bottom: 14.h,
                right:50.w,
                child: Container(
                  height: 35,

                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(color: AppColors.grey, width: 0.2.w),
                  ),
                  child: Row(
                    children: [
                      if (isOpen)
                      if (isOpen) SizedBox(width: 5.w),
                      if (isOpen)
                        InkWell(
                          onTap: isLoading
                              ? null
                              : () {
                                  if (count > 0) {
                                    count--;
                                    addToCart();
                                  }
                                  if (count == 0) {
                                    setState(() {
                                      isOpen = false;
                                    });
                                  }
                                },
                          child: CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            minRadius: 10.r,
                            child: Icon(
                              Icons.remove,
                              color: AppColors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      if (isOpen) SizedBox(width: 5.w),
                      if (isOpen)
                        Text(
                          count.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18
                          ),
                        ),
                      if (isOpen) SizedBox(width: 5.w),
                      InkWell(
                        onTap: isLoading
                            ? null
                            : () {
                                setState(() {
                                  isOpen = true;
                                });
                                if (count < widget.model!.quantity!) {
                                  setState(() {
                                    count++;
                                    addToCart();

                                  });
                                }
                              },
                        child: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          minRadius: 10,
                          child: Icon(
                            Icons.add,
                            color: AppColors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
        ],
      ),
    );
  }
}
