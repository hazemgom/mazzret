import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/product/create_product.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/widget/custom_details_product.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_product.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class AdminGetAllProduct extends StatefulWidget {
  const AdminGetAllProduct({Key? key}) : super(key: key);

  @override
  State<AdminGetAllProduct> createState() => _AdminGetAllProductState();
}

class _AdminGetAllProductState extends State<AdminGetAllProduct> {
  bool isSearching = false;
  // final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: isSearching == false
            ? Text(
                AppLocalizations.of(context)!.allProducts,
                style: AppFonts.titleScreen.copyWith(height: 0),
              )
            : BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  var productCubit = HomeCubit.get(context);

                  return TextFormField(
                    autofocus: true,
                    cursorColor: AppColors.grey,
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: AppColors.white,
                    ),
                    onChanged: (value) {
                      productCubit.searchProduct(
                        searchedProduct: value,
                        context: context,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.search,
                      hintStyle: GoogleFonts.cairo(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.grey,
                        ),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isSearching = false;
                            });
                            productCubit.searchProductList.clear();
                          },
                          icon: SvgPicture.asset(
                            'assets/images/close.svg',
                            color: AppColors.white,
                          )),
                    ),
                  );
                },
              ),
        centerTitle: true,
        actions: [
          isSearching == true
              ? Container()
              :
          IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: SvgPicture.asset(
                      'assets/images/search.svg',
                      color: Colors.white,
                    ),
                  ),
                ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var productCubit = HomeCubit.get(context);

          return productCubit.productModel == null ||
                  state is GetAllProductsLoadingState
              ? const Center(
                  child: CustomLoading(),
                )
              : productCubit.productModel!.data!.isEmpty
                  ? const Text('Empty')
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: productCubit.searchProductList.isEmpty
                          ? productCubit.productModel!.data!.length
                          : productCubit.searchProductList.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 36.h),
                                child: Container(
                                    width: 340.w,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        border: Border.all(
                                            width: 0.2.w,
                                            color: AppColors.grey)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 2.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: CachedImage(
                                              link: productCubit
                                                      .searchProductList.isEmpty
                                                  ? productCubit.productModel!
                                                      .data![index].image!.url!
                                                  : productCubit
                                                      .searchProductList[index]
                                                      .image!
                                                      .url,
                                              borderRadius: 12.r,
                                              width: 400.w,
                                              height: 120.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            '${AppLocalizations.of(context)!.nameOfProduct}: ${MyCache.getString(key: CacheKeys.lang) == 'ar' ? productCubit.searchProductList.isEmpty ? productCubit.productModel!.data![index].titleAr! : productCubit.searchProductList[index].titleAr : productCubit.searchProductList.isEmpty ? productCubit.productModel!.data![index].title! : productCubit.searchProductList[index].title}',
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
                                              '${productCubit.productModel!.data![index].descriptionAr == null ? '' : AppLocalizations.of(context)!.description} ${productCubit.productModel!.data![index].descriptionAr == null ? '' : ':'} ${MyCache.getString(key: CacheKeys.lang) == 'ar' ? productCubit.searchProductList.isEmpty ? productCubit.productModel!.data![index].descriptionAr ?? '' : productCubit.searchProductList[index].descriptionAr : productCubit.searchProductList.isEmpty ? productCubit.productModel!.data![index].description! : productCubit.searchProductList[index].description ?? ''}',
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.cairo(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.grey,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          const Divider(color: Colors.black38),
                                          SizedBox(height: 5.h),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .quantity,
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.cairo(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  Text(
                                                    '${productCubit.productModel!.data![index].quantity!}',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.cairo(
                                                      fontSize: 16.sp,
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
                                                AppLocalizations.of(context)!
                                                    .categoryName,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.cairo(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                MyCache.getString(
                                                            key: CacheKeys
                                                                .lang) ==
                                                        'ar'
                                                    ? productCubit
                                                            .searchProductList
                                                            .isEmpty
                                                        ? productCubit
                                                            .productModel!
                                                            .data![index]
                                                            .category!
                                                            .nameAr
                                                            .toString()
                                                        : productCubit
                                                            .searchProductList[
                                                                index]
                                                            .category!
                                                            .nameAr!
                                                    : productCubit
                                                            .searchProductList
                                                            .isEmpty
                                                        ? productCubit
                                                            .productModel!
                                                            .data![index]
                                                            .category!
                                                            .name!
                                                        : productCubit
                                                            .searchProductList[
                                                                index]
                                                            .category!
                                                            .name!,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.cairo(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // const Divider(color: Colors.black38),
                                          // SizedBox(height: 5.h),
                                          // InkWell(
                                          //   overlayColor:
                                          //       MaterialStateProperty.all(
                                          //     AppColors.primaryColor
                                          //         .withOpacity(0.2),
                                          //   ),
                                          //   onTap: () {
                                          //     Navigator.pushNamed(
                                          //       context,
                                          //       RouteName.editToProduct,
                                          //       arguments: productCubit
                                          //           .productModel!
                                          //           .data![index]
                                          //           .sId,
                                          //     );
                                          //   },
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment
                                          //             .spaceBetween,
                                          //     children: [
                                          //       Text(
                                          //         'أضغط هنا للتعديل علي المنتج',
                                          //         textAlign: TextAlign.center,
                                          //         style: GoogleFonts.cairo(
                                          //           fontSize: 16.sp,
                                          //           fontWeight: FontWeight.bold,
                                          //           color:
                                          //               AppColors.primaryColor,
                                          //         ),
                                          //       ),
                                          //       Icon(
                                          //         Icons.edit,
                                          //         color: AppColors.primaryColor,
                                          //         size: 20.sp,
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ))),
                          ),
                        );
                      },
                    );
        },
      ),
    );
  }
}
