import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/managers/admin_home_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/product/edite_to_product.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/widget/custom_details_product.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_back_for_app.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_category.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_empty.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'edit_category.dart';

class AdminDetailsCategory extends StatelessWidget {
  AdminDetailsCategory({
    Key? key,
    required this.image,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryId,
    required this.name,
    required this.namear,

  }) : super(key: key);
  String image;
  String name;
  String namear;
  String text;
  String createdAt;
  String updatedAt;
  String categoryId;

  String formattedDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat.yMMMMd().format(dateTime);
  }

  String formattedTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat.jm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      HomeCubit()..getProductsInCategory(categoryId: categoryId),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var categoryCubit = HomeCubit.get(context);

          return BlocConsumer<AdminHomeCubit, AdminHomeState>(
            listener: (context, state) {
              if (state is DeleteOneProductSuccessState) {
                Navigator.pushReplacementNamed(
                    context, RouteName.adminHomeLayoutRoute);
                BlocProvider.of<HomeCubit>(context).getAllProductsFunction();
                return CustomSnackBar.showMessage(
                  context,
                  message: 'تم حذف المنتج بنجاح',
                  messageColor: AppColors.primaryColor,
                );
              }
              if (state is DeleteCategorySuccessState) {
                Navigator.pushReplacementNamed(
                    context, RouteName.adminHomeLayoutRoute);
                BlocProvider.of<HomeCubit>(context).getCategoryList();
                return CustomSnackBar.showMessage(
                  context,
                  message: 'تم حذف الفئة بنجاح',
                  messageColor: AppColors.primaryColor,
                );
              } else if (state is DeleteCategoryErrorState) {
                return CustomSnackBar.showMessage(
                  context,
                  message: 'حدثت مشكلة أثناء حذف الفئة',
                  messageColor: Colors.red,
                );
              }
            },
            builder: (context, state) {
              var adminCubit = AdminHomeCubit.get(context);

              return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.primaryColor,
                  title: Text(
                    text,
                    style: AppFonts.titleScreen.copyWith(height: 0),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){

                          return AdminEditCategory(categoryId: categoryId,
                          nameAr:namear ,
                            name: name,
                            image: image,

                          );


                          ;
                        }));
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 18.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) => CustomBackForAppBar(
                            text:
                            '${AppLocalizations.of(context)!.doyouwantdeletethis} ${AppLocalizations.of(context)!.cate}',
                            onPressed: () {
                              adminCubit.deleteCategoryFunction(
                                  categoryId: categoryId);
                            },
                            text2: AppLocalizations.of(context)!.submit,
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.delete_forever_rounded,
                        color: AppColors.white,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
                body: categoryCubit.productsInCategoryModel == null ||
                    state is GetProductsInCategoryLoadingState
                    ? const Center(
                  child: CustomLoading(),
                )
                    : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 20.h),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(12.r),
                                  child: CachedNetworkImage(
                                    errorWidget: (context, url, error) {
                                      return SvgPicture.asset(
                                        AppAssets.emptyImage,
                                      );
                                    },
                                    imageUrl: image,
                                    width: 400.w,
                                    height: 230.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                    width: 120.w,
                                    height: 47.h,
                                    child: Text(
                                      text,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.cairo(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        // overflow: TextOverflow.clip,
                                      ),
                                      // style: AppFonts.categoryTitle,
                                    ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.createdate,
                              style: AppFonts.black2Text
                                  .copyWith(fontSize: 16.sp),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              formattedDate(createdAt),
                              style: AppFonts.greyText,
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1.w,
                        ),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.updatedat,
                              style: AppFonts.black2Text
                                  .copyWith(fontSize: 16.sp),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              formattedDate(updatedAt),
                              style: AppFonts.greyText,
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1.w,
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.allProducts} :-',
                              style: AppFonts.black2Text.copyWith(
                                fontSize: 16.sp,
                                height: 1.h,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteName.createProduct,
                                  arguments: {
                                    'categoryId': categoryId,
                                    'text': text,
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: AppColors.primaryColor,
                                    size: 20.sp,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .addnewProduct,
                                    style: AppFonts.black2Text.copyWith(
                                      fontSize: 16.sp,
                                      color: AppColors.primaryColor,
                                      height: 1.5.h,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: categoryCubit
                                .productsInCategoryModel!.data!.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  // CustomDetailsProductInWishList(
                                  //   icon: Container(),
                                  //   image: categoryCubit
                                  //       .productsInCategoryModel!
                                  //       .data![index]
                                  //       .image!
                                  //       .url!,
                                  //   text: categoryCubit
                                  //       .productsInCategoryModel!
                                  //       .data![index]
                                  //       .title!,
                                  //   text2: categoryCubit
                                  //       .productsInCategoryModel!
                                  //       .data![index]
                                  //       .description!,
                                  //   text3: categoryCubit
                                  //       .productsInCategoryModel!
                                  //       .data![index]
                                  //       .category!
                                  //       .name!,
                                  //   review: '', text4: '',
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 36.h),
                                    child: Container(
                                      width: 340.w,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5.r),
                                          border: Border.all(
                                              width: 0.2.w,
                                              color: AppColors.grey)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 2.h),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: CachedImage(
                                                link: categoryCubit
                                                    .productsInCategoryModel!
                                                    .data![index]
                                                    .image!
                                                    .url!,
                                                borderRadius: 12.r,
                                                width: 400.w,
                                                height: 120.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              '${AppLocalizations.of(context)!.nameOfProduct}: ${MyCache.getString(key: CacheKeys.lang) == 'ar' ? categoryCubit.productsInCategoryModel!.data![index].titleAr! : categoryCubit.productsInCategoryModel!.data![index].title!}',
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.cairo(
                                                fontSize: 18.sp,
                                                fontWeight:
                                                FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Container(
                                              width: 400.w,
                                              child: Text(
                                                '${categoryCubit.productsInCategoryModel!.data![index].descriptionAr == null ? '' : AppLocalizations.of(context)!.description} ${categoryCubit.productsInCategoryModel!.data![index].descriptionAr == null ? '' : ':'} ${MyCache.getString(key: CacheKeys.lang) == 'ar' ? categoryCubit.productsInCategoryModel!.data![index].descriptionAr ?? '' : categoryCubit.productsInCategoryModel!.data![index].description ?? ''}',
                                                textAlign:
                                                TextAlign.start,
                                                style: GoogleFonts.cairo(
                                                  fontSize: 15.sp,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  color: AppColors.grey,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            const Divider(
                                                color: Colors.black38),
                                            SizedBox(height: 5.h),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                          context)!
                                                          .quantity,
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
                                                      '${categoryCubit.productsInCategoryModel!.data![index].quantity!}',
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
                                                // const Spacer(),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(
                                                      context)!
                                                      .categoryName,
                                                  textAlign:
                                                  TextAlign.center,
                                                  style:
                                                  GoogleFonts.cairo(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                Text(
                                                  MyCache.getString(
                                                      key: CacheKeys
                                                          .lang) ==
                                                      'ar'
                                                      ? categoryCubit
                                                      .productsInCategoryModel!
                                                      .data![index]
                                                      .category!
                                                      .nameAr
                                                      .toString()
                                                      : categoryCubit
                                                      .productsInCategoryModel!
                                                      .data![index]
                                                      .category!
                                                      .name
                                                      .toString(),
                                                  textAlign:
                                                  TextAlign.center,
                                                  style:
                                                  GoogleFonts.cairo(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    color: AppColors
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                CustomButtonWidget(
                                                  height: 40.h,
                                                  width: 120.w,
                                                  text:
                                                  AppLocalizations.of(
                                                      context)!
                                                      .edit,
                                                  onPressed: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (
                                                        context
                                                        ){
                                                      return EditToProduct(productId: categoryCubit
                                                          .productsInCategoryModel!
                                                          .data![index]
                                                          .sId!,
                                                        titleAr: categoryCubit
                                                            .productsInCategoryModel!
                                                            .data![index]
                                                            .titleAr!,
                                                        quantity: categoryCubit
                                                            .productsInCategoryModel!
                                                            .data![index]
                                                            .quantity!,
                                                        priceNormal: categoryCubit
                                                            .productsInCategoryModel!
                                                            .data![index]
                                                            .priceNormal!,
                                                        descriptionAr: categoryCubit
                                                            .productsInCategoryModel!
                                                            .data![index]
                                                            .descriptionAr!,
                                                        description: categoryCubit
                                                            .productsInCategoryModel!
                                                            .data![index]
                                                            .description!,
                                                        title: categoryCubit
                                                            .productsInCategoryModel!
                                                            .data![index]
                                                            .title!,
                                                        priceWholesale: categoryCubit
                                                            .productsInCategoryModel!
                                                            .data![index]
                                                            .priceWholesale!,


                                                      );
                                                    }));
                                                  },
                                                ),
                                                state is DeleteOneProductLoadingState
                                                    ? const Center(
                                                  child:
                                                  CustomLoading(),
                                                )
                                                    : CustomButtonWidget(
                                                  height: 40.h,
                                                  width: 120.w,
                                                  text: AppLocalizations
                                                      .of(context)!
                                                      .delete,
                                                  onPressed: () {
                                                    adminCubit
                                                        .deleteProductFunction(
                                                      productId: categoryCubit
                                                          .productsInCategoryModel!
                                                          .data![
                                                      index]
                                                          .sId!,
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
