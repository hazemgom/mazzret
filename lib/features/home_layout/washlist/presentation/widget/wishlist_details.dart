import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/widget/custom_details_product.dart';
import 'package:mozart_flutter_app/features/home_layout/washlist/managers/wishlist_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_field_connect_us.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WishListDetailsScreen extends StatefulWidget {
  String? image, productName, desc, productId;
  dynamic? categoryName;

  WishListDetailsScreen({
    Key? key,
    this.categoryName,
    this.productName,
    this.image,
    this.desc,
    this.productId,
  }) : super(key: key);

  @override
  State<WishListDetailsScreen> createState() => _WishListDetailsScreenState();
}

class _WishListDetailsScreenState extends State<WishListDetailsScreen> {
  @override
  double? _ratingValue;
  TextEditingController controller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.productdetails,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // CustomDetailsProductInWishList(
                //   icon: Container(),
                //   image: widget.image!,
                //   text: widget.title!,
                //   text2: widget.desc!,
                //   text3: widget.price.toString(),
                //   review: '', text4: '',
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 36.h),
                  child: Container(
                    // height: 235.h,
                    width: 340.w,
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(
                            5.r),
                        border: Border.all(
                            width: 0.2.w,
                            color: AppColors.grey)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 2.h),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          Center(
                              child: CachedImage(
                                link: widget.image!,
                                borderRadius: 25.r,
                                width: 400.w,
                                height: 120.h,
                                fit: BoxFit.cover,
                              )),
                          SizedBox(height: 5.h),
                          Text(
                            widget.productName!,
                            textAlign:
                            TextAlign.start,
                            style:
                            GoogleFonts.cairo(
                              fontSize: 18.sp,
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Container(
                            width: 400.w,
                            child: Text(
                              widget.desc!,
                              textAlign:
                              TextAlign.start,
                              style:
                              GoogleFonts.cairo(
                                fontSize: 15.sp,
                                fontWeight:
                                FontWeight.w500,
                                color:
                                AppColors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          const Divider(
                              color:
                              Colors.black38),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(
                                        context)!
                                        .quantity,
                                    textAlign:
                                    TextAlign
                                        .center,
                                    style:
                                    GoogleFonts
                                        .cairo(
                                      fontSize:
                                      16.sp,
                                      fontWeight:
                                      FontWeight
                                          .normal,
                                      color: Colors
                                          .black,
                                    ),
                                  ),
                                  SizedBox(
                                      width: 5.w),
                                  // Text(
                                  //   // '${categoryCubit.productsInCategoryModel!.data![index].quantity}',
                                  //   textAlign:
                                  //   TextAlign
                                  //       .center,
                                  //   style:
                                  //   GoogleFonts
                                  //       .cairo(
                                  //     fontSize:
                                  //     16.sp,
                                  //     fontWeight:
                                  //     FontWeight
                                  //         .bold,
                                  //     color: AppColors
                                  //         .primaryColor,
                                  //   ),
                                  // ),
                                ],
                              ),
                              // const Spacer(),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(
                                    context)!
                                    .categoryName,
                                textAlign: TextAlign
                                    .center,
                                style: GoogleFonts
                                    .cairo(
                                  fontSize: 16.sp,
                                  fontWeight:
                                  FontWeight
                                      .normal,
                                  color:
                                  Colors.black,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                widget.categoryName,
                                textAlign: TextAlign
                                    .center,
                                style: GoogleFonts
                                    .cairo(
                                  fontSize: 16.sp,
                                  fontWeight:
                                  FontWeight
                                      .bold,
                                  color: AppColors
                                      .primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 5.w),
                          // Container(),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocConsumer<WishlistCubit, WishlistState>(
                  listener: (context, state) {
                    if (state is RemoveFromWishListSuccessState) {
                      Navigator.pop(context);
                      WishlistCubit.get(context)
                          .getWishListFunction();
                    }
                  },
                  builder: (context, state) {
                    var wishListCubit = WishlistCubit.get(context);

                    return state is RemoveFromWishListLoadingState
                        ? const Center(
                            child: CustomLoading(),
                          )
                        : CustomButtonWidget(
                            text: AppLocalizations.of(context)!
                                .removeFromFavorite,
                            height: 48.h,
                            width: 247.w,
                            onPressed: () {
                              wishListCubit.removeFromWishList(
                                  productId: widget.productId!);
                            },
                          );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.uploadimage,
                      style: AppFonts.blackText.copyWith(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                    height: 200,
                    width: 260,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                            width: 2.w, color: AppColors.primaryColor)),
                    child: Lottie.asset(AppAssets.uploadImage)),
                SizedBox(
                  height: 5.h,
                ),
                CustomButtonWidget(
                  text: AppLocalizations.of(context)!.sendimage,
                  height: 48.h,
                  width: 247.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
