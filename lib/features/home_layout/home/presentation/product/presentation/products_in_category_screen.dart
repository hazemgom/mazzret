import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/managers/user_cart_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/category/widgets/custom_get_all_products_component.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/widget/custom_details_product.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_empty.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

import '../../../../../admin/admin_get_all_orders/data/models/all_orders_in_model.dart';

class ProductsInCategoryScreen extends StatefulWidget {
  // String categoryId;
  Map map;
  String? selectedCategoryId;

  ProductsInCategoryScreen({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  State<ProductsInCategoryScreen> createState() =>
      _ProductsInCategoryScreenState();
}

class _ProductsInCategoryScreenState extends State<ProductsInCategoryScreen> {
  final ScrollController _scrollController = ScrollController();
  List<CartItems> itemsList = [];

  @override
  void initState() {
    context.read<UserCartCubit>().getAllUserCartFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.map['categoryId']);
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getProductsInCategory(categoryId: widget.map['categoryId'])
        ..getCategoryList(),
      child: BlocConsumer<UserCartCubit, UserCartState>(
        listener: (context, state) async {
          var userCartCubit = UserCartCubit.get(context);
          if (state is DeleteOneProductFromCartSuccessState ||
              state is DeleteAllProductsFromCartSuccessState) {
            await userCartCubit.getAllUserCartFunction();
          }
          if (state is UpdateUserCartSuccessState) {
            await userCartCubit.getAllUserCartFunction();
          }
        },
        builder: (context, state) {
          var userCartCubit = UserCartCubit.get(context);
          var userCartList = userCartCubit.userCartModel;

          return BlocConsumer<HomeCubit, HomeState>(
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
                CustomSnackBar.showMessage(
                  context,
                  message: AppLocalizations.of(context)!
                      .therewasaproblemaddingaproducttothecart,
                  messageColor: Colors.red,
                );
              }
            },
            builder: (context, state) {
              var categoryCubit = HomeCubit.get(context);

              return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.primaryColor,
                  title: Text(
                    AppLocalizations.of(context)!.allProductsInCategory,
                    style: AppFonts.titleScreen.copyWith(height: 0),
                  ),
                  centerTitle: true,
                ),
                floatingActionButton: MyCache.getBoolean(
                    defaultValue: false, key: CacheKeys.active) ==
                    false
                    ? Container()
                    :  GestureDetector(
                  onTap: () {
                    _scrollController.animateTo(
                      widget.map['index'] * (120.w + 8.w),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(50.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            spreadRadius: 10.r,
                            blurRadius: 10.r,
                            offset: Offset(5.w, 5.h),
                          ),
                        ]),
                    child: Text(
                      AppLocalizations.of(context)!.checkcurrentcategory,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                body: MyCache.getBoolean(
                            defaultValue: false, key: CacheKeys.active) ==
                        false
                    ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.notAuth,
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                      )
                    : state is GetProductsInCategoryLoadingState ||
                            categoryCubit.categoryModel == null ||
                            categoryCubit.productsInCategoryModel == null ||
                            userCartCubit.userCartModel == null
                        // userCartCubit.userCartModel!.data!.cartItems == null
                        ? const Center(
                            child: CustomLoading(),
                          )
                        : categoryCubit.productsInCategoryModel!.data!.isEmpty
                            ? CustomEmpty(
                                image: AppAssets.orderIcon,
                                text: AppLocalizations.of(context)!
                                    .noProductInThisCategoryYet,
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, RouteName.homeLayoutRoute);
                                },
                                textButton: AppLocalizations.of(context)!
                                    .continueShopping,
                              )
                            // : GridView.builder(
                            //     itemCount: categoryCubit.searchCategoryList.isEmpty
                            //         ? categoryCubit
                            //             .productsInCategoryModel!.data!.length
                            //         : categoryCubit.searchCategoryList.length,
                            //     primary: false,
                            //     gridDelegate:
                            //         SliverGridDelegateWithFixedCrossAxisCount(
                            //       crossAxisCount: 2,
                            //       childAspectRatio: 0.9.h,
                            //     ),
                            //     padding: EdgeInsets.all(10.sp),
                            //     itemBuilder: (context, index) {
                            //       return CustomGetAllProduct(
                            //         image: categoryCubit.productsInCategoryModel!
                            //             .data![index].image!.url!,
                            //         nameOfProduct:
                            //             MyCache.getString(key: CacheKeys.lang) ==
                            //                     'en'
                            //                 ? categoryCubit.productsInCategoryModel!
                            //                     .data![index].title!
                            //                 : categoryCubit.productsInCategoryModel!
                            //                     .data![index].titleAr!,
                            //         index: index,
                            //         counter: userCartList!
                            //                 .data!.cartItems![index].quantity,
                            //         quantity: userCartList
                            //                 .data!.cartItems![index].quantity ??
                            //             1,
                            //         onTap: () {},
                            //       );
                            //     },
                            //   ),
                            : Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.075,
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      padding: EdgeInsets.only(
                                        top: 20.h,
                                        right: MyCache.getString(
                                                    key: CacheKeys.lang) ==
                                                'ar'
                                            ? 10.w
                                            : 0,
                                        left: MyCache.getString(
                                                    key: CacheKeys.lang) ==
                                                'ar'
                                            ? 0
                                            : 10.w,
                                      ),
                                      child: ListView.separated(
                                        controller: _scrollController,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: categoryCubit
                                            .categoryModel!.data!.length,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(width: 8.w);
                                        },
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              widget.selectedCategoryId =
                                                  categoryCubit.categoryModel!
                                                      .data![index].sId!;
                                              widget.map['categoryId'] =
                                                  widget.selectedCategoryId!;
                                              categoryCubit
                                                  .getProductsInCategory(
                                                categoryId: categoryCubit
                                                    .categoryModel!
                                                    .data![index]
                                                    .sId!,
                                              );
                                            },
                                            child: Container(
                                              height: 50.h,
                                              width: 120.w,
                                              // padding: EdgeInsets.all(20.sp),
                                              decoration: BoxDecoration(
                                                color:
                                                    widget.map['categoryId'] ==
                                                            categoryCubit
                                                                .categoryModel!
                                                                .data![index]
                                                                .sId!
                                                        ? AppColors.primaryColor
                                                        : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(24.r),
                                                border: Border.all(
                                                  color: AppColors.primaryColor,
                                                  width: 1.5.w,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  MyCache.getString(
                                                              key: CacheKeys
                                                                  .lang) ==
                                                          'ar'
                                                      ? categoryCubit
                                                          .categoryModel!
                                                          .data![index]
                                                          .nameAr!
                                                      : categoryCubit
                                                          .categoryModel!
                                                          .data![index]
                                                          .name!,
                                                  style: GoogleFonts.cairo(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: widget.map[
                                                                'categoryId'] ==
                                                            categoryCubit
                                                                .categoryModel!
                                                                .data![index]
                                                                .sId!
                                                        ? AppColors.white
                                                        : Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 0.h),
                                    BlocProvider(
                                      create: (context) =>
                                          HomeCubit()..getCategoryList(),
                                      child: Center(
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.78,
                                          child: ListView.builder(
                                            // physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: categoryCubit
                                                .productsInCategoryModel!
                                                .data!
                                                .length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 36.h),
                                                    child: Container(
                                                      // height: 235.h,
                                                      width: 340.w,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.h),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.r),
                                                          border: Border.all(
                                                              width: 0.2.w,
                                                              color: AppColors
                                                                  .grey)),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w,
                                                                vertical: 2.h),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Center(
                                                                child:
                                                                    CachedImage(
                                                              link: categoryCubit
                                                                  .productsInCategoryModel!
                                                                  .data![index]
                                                                  .image!
                                                                  .url!,
                                                              borderRadius:
                                                                  25.r,
                                                              width: 400.w,
                                                              height: 120.h,
                                                              fit: BoxFit.cover,
                                                            )),
                                                            SizedBox(
                                                                height: 5.h),
                                                            Text(
                                                              '${AppLocalizations.of(context)!.nameOfProduct}: ${MyCache.getString(key: CacheKeys.lang) == 'ar' ? categoryCubit.productsInCategoryModel!.data![index].titleAr! : categoryCubit.productsInCategoryModel!.data![index].title!}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: GoogleFonts
                                                                  .cairo(
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 5.h),
                                                            Container(
                                                              width: 400.w,
                                                              child: Text(
                                                                '${categoryCubit.productsInCategoryModel!.data![index].descriptionAr == null ? '' : AppLocalizations.of(context)!.description} ${categoryCubit.productsInCategoryModel!.data![index].descriptionAr == null ? '' : ':'} ${MyCache.getString(key: CacheKeys.lang) == 'ar' ? categoryCubit.productsInCategoryModel!.data![index].descriptionAr ?? '' : categoryCubit.productsInCategoryModel!.data![index].description ?? ''}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    GoogleFonts
                                                                        .cairo(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      AppColors
                                                                          .grey,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 5.h),
                                                            const Divider(
                                                                color: Colors
                                                                    .black38),
                                                            SizedBox(
                                                                height: 5.h),
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
                                                                      style: GoogleFonts
                                                                          .cairo(
                                                                        fontSize:
                                                                            16.sp,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        width: 5
                                                                            .w),
                                                                    Text(
                                                                      '${categoryCubit.productsInCategoryModel!.data![index].quantity}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .cairo(
                                                                        fontSize:
                                                                            16.sp,
                                                                        fontWeight:
                                                                            FontWeight.bold,
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
                                                                Text(
                                                                  MyCache.getString(key: CacheKeys.lang) ==
                                                                          'ar'
                                                                      ? categoryCubit
                                                                              .productsInCategoryModel!
                                                                              .data![
                                                                                  index]
                                                                              .category!
                                                                              .nameAr ??
                                                                          categoryCubit
                                                                              .productsInCategoryModel!
                                                                              .data![
                                                                                  index]
                                                                              .category!
                                                                              .name!
                                                                      : categoryCubit
                                                                          .productsInCategoryModel!
                                                                          .data![
                                                                              index]
                                                                          .category!
                                                                          .name!,
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
                                                                            .bold,
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 5.w),
                                                            const Divider(
                                                                color: Colors
                                                                    .black38),
                                                            // categoryCubit
                                                            //     .productsInCategoryModel!
                                                            //     .data![
                                                            // index]
                                                            //     .sId ==
                                                            //     userCartCubit
                                                            //         .userCartModel!
                                                            //         .data!
                                                            //         .cartItems![
                                                            //     index]
                                                            //         .sId
                                                            //     ? Row(
                                                            //   children: [
                                                            //     IconButton(
                                                            //         onPressed:
                                                            //             () {
                                                            //           setState(
                                                            //                   () {
                                                            //                 userCartList!.data!.cartItems![index].quantity =
                                                            //                 (userCartList.data!.cartItems![index].quantity! + 1);
                                                            //               });
                                                            //           userCartCubit
                                                            //               .updateUserCartFunction(
                                                            //             productId:
                                                            //             userCartList!.data!.cartItems![index].sId!,
                                                            //             // .cartItems![index].sId!,
                                                            //             quantity:
                                                            //             userCartList.data!.cartItems![index].quantity!,
                                                            //           );
                                                            //         },
                                                            //         icon: Icon(
                                                            //             Icons.add)),
                                                            //     Text(
                                                            //       userCartList!
                                                            //           .data!
                                                            //           .cartItems![
                                                            //       index]
                                                            //           .quantity
                                                            //           .toString(),
                                                            //       textAlign:
                                                            //       TextAlign
                                                            //           .center,
                                                            //       style: GoogleFonts.cairo(
                                                            //           color: Colors
                                                            //               .black38,
                                                            //           fontSize: 16
                                                            //               .sp,
                                                            //           fontWeight:
                                                            //           FontWeight.bold),
                                                            //     ),
                                                            //     IconButton(
                                                            //         onPressed:
                                                            //             () {
                                                            //           setState(
                                                            //                   () {
                                                            //                 if (userCartList.data!.cartItems![index].quantity! <=
                                                            //                     1) {
                                                            //                   CustomSnackBar.showMessage(context, message: AppLocalizations.of(context)!.thereisanirreversibleproblem, messageColor: Colors.red);
                                                            //                 } else {
                                                            //                   userCartList.data!.cartItems![index].quantity = (userCartList.data!.cartItems![index].quantity! - 1);
                                                            //                 }
                                                            //               });
                                                            //           userCartCubit
                                                            //               .updateUserCartFunction(
                                                            //             productId:
                                                            //             userCartList!.data!.cartItems![index].sId!,
                                                            //             quantity:
                                                            //             userCartList.data!.cartItems![index].quantity!,
                                                            //           );
                                                            //         },
                                                            //         icon: Icon(
                                                            //             Icons.remove)),
                                                            //   ],
                                                            // ) ,
                                                            InkWell(
                                                              overlayColor:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                AppColors
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        0.2),
                                                              ),
                                                              onTap: () {
                                                                categoryCubit
                                                                    .addToCart(
                                                                  productId: categoryCubit
                                                                      .productsInCategoryModel!
                                                                      .data![
                                                                          index]
                                                                      .id!,
                                                                );
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  // Icon(Icons.add),
                                                                  // Text(
                                                                  //   userCartCubit
                                                                  //           .userCartModel!
                                                                  //           .data!
                                                                  //           .cartItems![
                                                                  //               index]
                                                                  //           .quantity
                                                                  //           .toString()
                                                                  //     ,
                                                                  // ),
                                                                  Text(
                                                                    '${AppLocalizations.of(context)!.addtocart}.',
                                                                    style: AppFonts
                                                                        .descInWishList
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .primaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                      fontSize:
                                                                          16.sp,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // Container(),
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
                                      ),
                                    ),
                                  ],
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
