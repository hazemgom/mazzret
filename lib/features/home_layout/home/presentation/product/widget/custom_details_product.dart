import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDetailsProductInWishList extends StatefulWidget {
  CustomDetailsProductInWishList({
    Key? key,
    required this.image,
    required this.text,
    this.text2,
    this.email,
    this.phone,
    this.quantity = 1,
    required this.icon,
    required this.text3,
    required this.text4,
    required this.review,
    this.widgetAddToCart,
  }) : super(key: key);
  String image;
  String text;
  String? text2;
  String? phone;
  String? email;
  String text3;
  String text4;
  String review;
  int quantity;
  Widget icon;
  Widget? widgetAddToCart;

  @override
  State<CustomDetailsProductInWishList> createState() =>
      _CustomDetailsProductInWishListState();
}

class _CustomDetailsProductInWishListState
    extends State<CustomDetailsProductInWishList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 36.h),
          child: Container(
            // height: 235.h,
            width: 340.w,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(width: 0.2.w, color: AppColors.grey)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: CachedImage(
                    link: widget.image,
                    borderRadius: 25.r,
                    width: 400.w,
                    height: 120.h,
                    fit: BoxFit.cover,
                  )),
                  SizedBox(height: 5.h),
                  Text(
                    '${AppLocalizations.of(context)!.nameOfProduct}: ${widget.text}',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: 400.w,
                    child: Text(
                      '${AppLocalizations.of(context)!.nameOfUser}: ${widget.text2}',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.cairo(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  MyCache.getString(key: CacheKeys.role) == 'manager' ||
                          MyCache.getString(key: CacheKeys.role) == 'admin'
                      ? Container(
                          width: 400.w,
                          child: Text(
                            '${AppLocalizations.of(context)!.email}: ${widget.email}',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.cairo(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                            ),
                          ),
                        )
                      : Container(),
                  MyCache.getString(key: CacheKeys.role) == 'manager' ||
                          MyCache.getString(key: CacheKeys.role) == 'admin'
                      ? Container(
                          width: 400.w,
                          child: Text(
                            '${AppLocalizations.of(context)!.phonenumber}: ${widget.phone}',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.cairo(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 5.h),
                  const Divider(color: Colors.black38),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       widget.quantity++;
                      //     });
                      //   },
                      //   child: Card(
                      //     elevation: 1,
                      //     child: Container(
                      //       height: 25.h,
                      //       width: 25.w,
                      //       decoration: BoxDecoration(
                      //         color: AppColors.primaryColor,
                      //         borderRadius: BorderRadius.circular(5.w),
                      //       ),
                      //       child: Center(
                      //         child: Icon(
                      //           Icons.add,
                      //           color: AppColors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 5.w,
                      // ),
                      // Text(
                      //   "${widget.quantity}",
                      //   style: TextStyle(fontSize: 18.sp),
                      // ),
                      // SizedBox(
                      //   width: 5.w,
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       widget.quantity--;
                      //     });
                      //   },
                      //   child: Card(
                      //     elevation: 1,
                      //     child: Container(
                      //       height: 25.h,
                      //       width: 25.w,
                      //       decoration: BoxDecoration(
                      //         color: AppColors.blue,
                      //         borderRadius: BorderRadius.circular(5.w),
                      //       ),
                      //       child: Center(
                      //         child: Icon(Icons.remove),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.quantity,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '${widget.quantity}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      // const Spacer(),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.categoryName,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        widget.text3,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       '${widget.review}: ',
                  //       textAlign: TextAlign.center,
                  //       style: GoogleFonts.cairo(
                  //         fontSize: 16.sp,
                  //         fontWeight: FontWeight.normal,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     SizedBox(width: 5.w),
                  // Directionality(
                  //   textDirection: MyCache.getString(
                  //       key: CacheKeys.lang) ==
                  //       'ar'
                  //       ? TextDirection.rtl
                  //       : TextDirection.ltr,
                  //   child: RatingBar(
                  //       itemSize: 30.sp,
                  //       initialRating: 5,
                  //       direction: Axis.horizontal,
                  //       allowHalfRating: true,
                  //       itemCount: 5,
                  //       ratingWidget: RatingWidget(
                  //           full: const Icon(Icons.star,
                  //               color: Colors.orange),
                  //           half: const Icon(
                  //             Icons.star_half,
                  //             color: Colors.orange,
                  //           ),
                  //           empty: const Icon(
                  //             Icons.star_outline,
                  //             color: Colors.orange,
                  //           )),
                  //       onRatingUpdate: (value) {
                  //         // setState(() {
                  //         //   double.parse(widget.text4) = value;
                  //         // });
                  //       }),
                  // ),

                  // Text(
                  //   '${widget.text4}',
                  //   textAlign: TextAlign.center,
                  //   style: GoogleFonts.cairo(
                  //     fontSize: 16.sp,
                  //     fontWeight: FontWeight.bold,
                  //     color: AppColors.primaryColor,
                  //   ),
                  // ),
                  // ],
                  // ),
                  widget.widgetAddToCart == null
                      ? Container()
                      : SizedBox(width: 5.w),
                  widget.widgetAddToCart == null
                      ? Container()
                      : const Divider(color: Colors.black38),
                  widget.widgetAddToCart ?? Container(),
                ],
              ),
            ),
          ),
        ),
        // Positioned(
        //     top: 50.h,
        //     left: 30.h,
        //     child: SvgPicture.asset(
        //       AppAssets.loveIcon,
        //       width: 30.w,
        //       height: 30.h,
        //     )),
        Positioned(
          top: 50.h,
          right: 30.h,
          child: widget.icon!,
        ),
      ],
    );
  }
}
