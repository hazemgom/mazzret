import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/managers/user_cart_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_field_connect_us.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailsProduct extends StatefulWidget {
  final String? productId;

  const DetailsProduct({
    Key? key,
    this.productId,
  }) : super(key: key);

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  String? imagePath;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  @override
  double _ratingValue = 0.0;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getSpecificProductFunction(productId: widget.productId!),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) async {
          if (state is AddToCartSuccessState) {
            CustomSnackBar.showMessage(
              context,
              message: AppLocalizations.of(context)!
                  .theproducthasbeenaddedsuccessfully,
              messageColor: AppColors.primaryColor,
            );
            await UserCartCubit.get(context).getAllUserCartFunction();
          } else if (state is AddToCartErrorState) {
            if (MyCache.getBoolean(
                    defaultValue: false, key: CacheKeys.active) ==
                false) {
              CustomSnackBar.showMessage(
                context,
                message: AppLocalizations.of(context)!.notAuth,
                messageColor: Colors.red,
              );
            } else {
              CustomSnackBar.showMessage(
                context,
                message: AppLocalizations.of(context)!.errorInAddToCart,
                messageColor: Colors.red,
              );
            }
          }
          if (state is AddReviewSuccessState) {
            CustomSnackBar.showMessage(
              context,
              message: AppLocalizations.of(context)!.ratingaddedsuccessfully,
              messageColor: AppColors.primaryColor,
            );
            setState(() {
              _ratingValue = 0;
              controller.text = '';
            });
          } else if (state is AddReviewErrorState) {
            CustomSnackBar.showMessage(
              context,
              message: AppLocalizations.of(context)!
                  .therewereproblemswhileevaluatingthisproduct,
              messageColor: Colors.red,
            );
          }
          if (state is AddToFavoriteSuccessState) {
            CustomSnackBar.showMessage(
              context,
              message: AppLocalizations.of(context)!
                  .theproducthasbeensuccessfullyaddedtoyourfavorites,
              messageColor: AppColors.primaryColor,
            );
          } else if (state is AddToFavoriteErrorState) {
            CustomSnackBar.showMessage(
              context,
              message: AppLocalizations.of(context)!
                  .addingtheproducttofavoritesfailed,
              messageColor: Colors.red,
            );
          }
          if (state is UploadImageToAdminSuccessState) {
            CustomSnackBar.showMessage(
              context,
              message: AppLocalizations.of(context)!
                  .thesuggestedimagehasbeenuploadedsuccessfully,
              messageColor: AppColors.primaryColor,
            );
            // imagePath = '';
          } else if (state is UploadImageToAdminErrorState) {
            CustomSnackBar.showMessage(context,
                message: 'Faliur', messageColor: Colors.red);
          }
        },
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              title: Text(
                AppLocalizations.of(context)!.productdetails,
                style: AppFonts.titleScreen.copyWith(height: 0),
              ),
              centerTitle: true,
            ),
            body: state is GetSpecificProductLoadingState
                ? const Center(
                    child: CustomLoading(),
                  )
                : homeCubit.specificProductModel == null
                    ? const Center(child: Text('Empty'))
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 5.h,
                                        ),
                                        // height: 180.h,
                                        // constraints: BoxConstraints(
                                        //   minHeight: 180.h,
                                        //   maxHeight: 400.h,
                                        // ),
                                        width: 400.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          border: Border.all(
                                              color: AppColors.grey,
                                              width: 0.2.w),
                                        ),
                                        child: SizedBox(
                                          width: 140.w,
                                          child: Column(
                                            children: [
                                              CachedImage(
                                                link: homeCubit
                                                    .specificProductModel!
                                                    .data!
                                                    .image!
                                                    .url!,
                                                borderRadius: 14.r,
                                                // width: 99.w,
                                                // height: 75.h,
                                                width: 400.w,
                                                height: 120.h,
                                                fit: BoxFit.cover,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 200.w,
                                                    child: Text(
                                                      '${AppLocalizations.of(context)!.productname} ${MyCache.getString(key: CacheKeys.lang) == 'ar' ? homeCubit.specificProductModel!.data!.titleAr : homeCubit.specificProductModel!.data!.title!}',
                                                      style:
                                                          AppFonts.black2Text,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 300.w,
                                                    child: Text(
                                                      '${AppLocalizations.of(context)!.desname} ${MyCache.getString(key: CacheKeys.lang) == 'ar' ? homeCubit.specificProductModel!.data!.descriptionAr : homeCubit.specificProductModel!.data!.description}',
                                                      style: AppFonts
                                                          .descInWishList,
                                                      // overflow: TextOverflow.clip,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    // width: 130.w,
                                                    child: Text(
                                                      '${MyCache.getString(key: CacheKeys.role) == 'user-normal' ? homeCubit.specificProductModel!.data!.priceNormal : homeCubit.specificProductModel!.data!.priceWholesale} ${AppLocalizations.of(context)!.egp}',
                                                      style: AppFonts
                                                          .descInWishList
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primaryColor),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    // width: 130.w,
                                                    child: Text(
                                                      '${AppLocalizations.of(context)!.ratingaverage}: ${homeCubit.specificProductModel!.data!.ratingsAverage ?? 0}',
                                                      style: AppFonts
                                                          .descInWishList
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primaryColor),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                  color: Colors.black38),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    // width: 130.w,
                                                    child: Text(
                                                      '${AppLocalizations.of(context)!.quantityofpiecessold}: ${homeCubit.specificProductModel!.data!.sold}',
                                                      style: AppFonts
                                                          .descInWishList
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primaryColor),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    // width: 130.w,
                                                    child: Text(
                                                      '${AppLocalizations.of(context)!.ratingsquantity}: ${homeCubit.specificProductModel!.data!.ratingsQuantity}',
                                                      style: AppFonts
                                                          .descInWishList
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primaryColor),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                  color: Colors.black38),
                                              InkWell(
                                                onTap: () {
                                                  homeCubit
                                                      .addToFavoriteFunction(
                                                    productId: homeCubit
                                                        .specificProductModel!
                                                        .data!
                                                        .sId!,
                                                  );
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${AppLocalizations.of(context)!.addToFavorite}.',
                                                      style: AppFonts
                                                          .descInWishList
                                                          .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        fontSize: 16.sp,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //     top: 18.h,
                                      //     left: 20.h,
                                      //     child: GestureDetector(
                                      //       onTap: () {
                                      //         setState(() {
                                      //           isFavorite = !isFavorite;
                                      //         });
                                      //       },
                                      //       child: isFavorite ? SvgPicture.asset(
                                      //         AppAssets.favoriteIcon,
                                      //         width: 30.w,
                                      //         height: 30.h,
                                      //       ) : SvgPicture.asset(
                                      //         AppAssets.loveIcon,
                                      //         width: 30.w,
                                      //         height: 30.h,
                                      //       ),
                                      //     )),
                                      // Positioned(
                                      //   top: 18.h,
                                      //   right: 20.w,
                                      //   child: CircleAvatar(
                                      //     backgroundColor: AppColors.primaryColor,
                                      //     minRadius: 10.r,
                                      //     child: Icon(
                                      //       Icons.add,
                                      //       color: AppColors.white,
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                state is AddToCartLoadingState
                                    ? const Center(child: CustomLoading())
                                    : CustomButtonWidget(
                                        onPressed: () {
                                          homeCubit.addToCart(
                                              productId: widget.productId!);
                                        },
                                        text: AppLocalizations.of(context)!
                                            .addtocart,
                                        height: 48.h,
                                        width: 247.w,
                                      ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Divider(
                                  thickness: 0.2.sp,
                                  color: AppColors.grey,
                                ),

                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.review,
                                      style: AppFonts.blackText.copyWith(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Directionality(
                                      textDirection: MyCache.getString(
                                                  key: CacheKeys.lang) ==
                                              'ar'
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                      child: RatingBar(
                                          itemSize: 30.sp,
                                          initialRating: _ratingValue ?? 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          ratingWidget: RatingWidget(
                                              full: const Icon(Icons.star,
                                                  color: Colors.orange),
                                              half: const Icon(
                                                Icons.star_half,
                                                color: Colors.orange,
                                              ),
                                              empty: const Icon(
                                                Icons.star_outline,
                                                color: Colors.orange,
                                              )),
                                          onRatingUpdate: (value) {
                                            setState(() {
                                              _ratingValue = value;
                                            });
                                          }),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 10.h,
                                ),
                                CustomTextFormFieldConnectUs(
                                  controller: controller,
                                  maxLines: 3,
                                  label: AppLocalizations.of(context)!.review,
                                  validator: (p0) {},
                                ),

                                SizedBox(
                                  height: 30.h,
                                ),
                                state is AddReviewLoadingState
                                    ? const Center(child: CustomLoading())
                                    : CustomButtonWidget(
                                        onPressed: () {
                                          if (_ratingValue != 0.0) {
                                            homeCubit.addReviewFunction(
                                              title: controller.text,
                                              ratings: _ratingValue,
                                              productId: widget.productId!,
                                            );
                                          } else {
                                            CustomSnackBar.showMessage(
                                              context,
                                              message:
                                                  AppLocalizations.of(context)!
                                                      .pleaserate,
                                              messageColor: Colors.red,
                                            );
                                          }
                                        },
                                        text: AppLocalizations.of(context)!
                                            .sendfeedback,
                                        height: 48.h,
                                        width: 247.w,
                                      ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Divider(
                                  thickness: 0.2.sp,
                                  color: AppColors.grey,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.uploadimage,
                                      style: AppFonts.blackText.copyWith(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                GestureDetector(
                                  // onTap: () {
                                  //   ImagePicker(
                                  //     ImageSource.gallery,
                                  //     imageFile,
                                  //   );
                                  // },
                                  onTap: _pickImage,
                                  child: Container(
                                    height: 200.h,
                                    width: 260.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      border: Border.all(
                                        width: 2.w,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    child: imagePath != null
                                        ? Image.file(
                                            File(imagePath!),
                                            fit: BoxFit.cover,
                                          )
                                        : Lottie.asset(AppAssets.uploadImage),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                state is UploadImageToAdminLoadingState
                                    ? const Center(
                                        child: CustomLoading(),
                                      )
                                    : CustomButtonWidget(
                                        text: AppLocalizations.of(context)!
                                            .sendimage,
                                        height: 48.h,
                                        width: 247.w,
                                        onPressed: () async {
                                          if (imagePath != null) {
                                            File imageFile = File(imagePath!);

                                            homeCubit.uploadImageToServer(
                                              imageFile,
                                              homeCubit.specificProductModel!
                                                  .data!.title!,
                                              homeCubit.specificProductModel!
                                                  .data!.sId!,
                                            );
                                          }
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
          );
        },
      ),
    );
  }
}
