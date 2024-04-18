import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/bannner/Banner2-screen.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/auth/managers/auth_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/data/models/user_cart_model.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/presentation/details_product.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/widget/custom_container.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_banner.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_category.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_page_view.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_product.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/navigation.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController? pageController;
  List<String> image = [
    AppAssets.product1,
    AppAssets.product2,
    AppAssets.product3,
  ];

  @override
  void initState() {
    // pageController = PageController(
    //   initialPage: 0,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getBanners()
        ..getProductInHighSold()
        ..getCategoryList(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // if (state is GetProductsInCategoryErrorState) {
          //   return CustomSnackBar.showMessage(
          //     context,
          //     message: 'برجاء أعادة المحاولة!',
          //     messageColor: Colors.red,
          //   );
          // }
        },
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);

          return SingleChildScrollView(
            child: Column(
              children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: BannerScreen(),
                 ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.pushNamed(
                //             context, RouteName.getAllProductsRoute);
                //       },
                //       child: DottedBorder(
                //         borderType: BorderType.RRect,
                //         radius: Radius.circular(8.r),
                //         color: AppColors.primaryColor,
                //         child: CustomContainer(
                //           height: 80.h,
                //           width: 160.w,
                //           color: AppColors.white,
                //           text:
                //               '${AppLocalizations.of(context)!.onlyattomato200products} ${homeCubit.productModel == null ? '...' : homeCubit.productModel!.data!.length} ${AppLocalizations.of(context)!.product}',
                //           textStyle: AppFonts.primarytext
                //               .copyWith(color: Colors.black, fontSize: 13.sp),
                //           image: AppAssets.logoIcon2,
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 15.w),
                //     DottedBorder(
                //       borderType: BorderType.RRect,
                //       radius: Radius.circular(8.r),
                //       color: AppColors.primaryColor,
                //       child: CustomContainer(
                //           height: 80.h,
                //           width: 160.w,
                //           color: AppColors.white,
                //           text: AppLocalizations.of(context)!
                //               .availableinoffersweekly20products,
                //           textStyle:
                //               AppFonts.primarytext.copyWith(fontSize: 13.sp),
                //           image: AppAssets.discount),
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 12.h),
                //   child: Row(
                //     children: [
                //       CustomCategory(
                //         image: AppAssets.category1,
                //         text: AppLocalizations.of(context)!.icecreame,
                //       ),
                //       CustomCategory(
                //         image: AppAssets.category2,
                //         text: AppLocalizations.of(context)!.meatandchicken,
                //       ),
                //       CustomCategory(
                //         image: AppAssets.category3,
                //         text: AppLocalizations.of(context)!.waters,
                //       ),
                //       CustomCategory(
                //         image: AppAssets.category4,
                //         text: AppLocalizations.of(context)!.colddrinks,
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 12.h),
                //   child: Row(
                //     children: [
                //       CustomCategory(
                //         image: AppAssets.category5,
                //         text: AppLocalizations.of(context)!.fruitsandvegetables,
                //       ),
                //       CustomCategory(
                //         image: AppAssets.category6,
                //         text: AppLocalizations.of(context)!.bakedgoods,
                //       ),
                //       CustomCategory(
                //         image: AppAssets.category7,
                //         text: AppLocalizations.of(context)!.dairyandmilk,
                //       ),
                //       CustomCategory(
                //         image: AppAssets.category8,
                //         text: AppLocalizations.of(context)!.thebreakfast,
                //       ),
                //     ],
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.getCategoriesRoute);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 15.w, top: 15.h, right: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.featuredcateory,
                          style: AppFonts.primarytext.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          AppLocalizations.of(context)!.showmore,
                          style: AppFonts.primarytext
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Categories
                state is GetCategoryLoadingState
                    ? Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: const CustomLoading(),
                      )
                    : homeCubit.categoryModel == null
                        ? Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: const CustomLoading(),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 20.h),
                            height: 140.h,
                            child: ListView.builder(
                              shrinkWrap: true,
                              // padding: EdgeInsets.symmetric(horizontal: 40.w),
                              scrollDirection: Axis.horizontal,
                              itemCount: homeCubit.categoryModel!.data!.length,
                              itemBuilder: (context, index) {
                                String image = homeCubit
                                    .categoryModel!.data![index].image!.url!;
                                // homeCubit.categoryModel!.data![index].image!;
                                String text =
                                    MyCache.getString(key: CacheKeys.lang) ==
                                            'ar'
                                        ? homeCubit.categoryModel!.data![index]
                                                .nameAr ??
                                            homeCubit.categoryModel!
                                                .data![index].name!
                                        : homeCubit
                                            .categoryModel!.data![index].name!;
                                return CustomCategory(
                                  image: image,
                                  text: text,
                                  onTap: () async {
                                    print(
                                        '-------${homeCubit.categoryModel!.data![index].sId!}---------');
                                    // CustomSnackBar.showMessage(
                                    //   context,
                                    //   message: AppLocalizations.of(context)!.justtakeafewsecondstodownloadalltheproducts,
                                    //   messageColor: AppColors.primaryColor,
                                    // );
                                    // await homeCubit.getProductsInCategory(
                                    //     categoryId: homeCubit
                                    //         .categoryModel!.data![index].sId!);

                                    Map map = {
                                      'categoryId': homeCubit
                                          .categoryModel!.data![index].sId,
                                      'index': index,
                                    };
                                    await Navigator.pushNamed(
                                      context,
                                      RouteName.productsInCategoryScreenRoute,
                                      arguments: map,
                                    );
                                  },
                                );
                              },
                            ),
                          ),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.getAllProductsRoute);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.featuredproducts,
                          style: AppFonts.primarytext.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          AppLocalizations.of(context)!.showmore,
                          style: AppFonts.primarytext
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Products
                state is GetProductHighNySoldLoadingState || homeCubit.productModel == null
                    ? Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: const CustomLoading(),
                      )
                    : GridView.builder(
                        // scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: homeCubit.productModel!.data!.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1.h,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                FadePageRoute(
                                  builder: (context) => DetailsProduct(
                                    productId: homeCubit
                                        .productModel!.data![index].id!,
                                  ),
                                ),
                              );
                              homeCubit.getSpecificProductFunction(
                                productId: homeCubit
                                    .productModel!.data![index].id!,
                              );
                            },
                            child: CustomProduct(
                              cubit: homeCubit,
                                model: homeCubit
                                    .productModel!.data![index],
                                width: 180.w,
                                image: homeCubit
                                    .productModel!.data![index].image!.url!,
                                text1: MyCache.getString(
                                            key: CacheKeys.lang) ==
                                        'ar'
                                    ? homeCubit
                                        .productModel!.data![index].titleAr!
                                    : homeCubit
                                        .productModel!.data![index].title!,
                                text2: '${MyCache.getString(key: CacheKeys.role) == 'user-normal' ? homeCubit.productModel!.data![index].priceNormal! : homeCubit.productModel!.data![index].priceWholesale!} ${AppLocalizations.of(context)!.egp}'),
                          );
                        }),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         AppLocalizations.of(context)!.topratedproducts,
                //         style: AppFonts.primarytext.copyWith(
                //             color: Colors.black, fontWeight: FontWeight.w600),
                //       ),
                //       Text(
                //         AppLocalizations.of(context)!.showmore,
                //         style: AppFonts.primarytext
                //             .copyWith(fontWeight: FontWeight.w600),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 155.h,
                //   width: double.infinity,
                //   child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: image.length,
                //       itemBuilder: (context, index) {
                //         return CustomProduct(
                //           image: image[1],
                //           text1: AppLocalizations.of(context)!.helloketchup,
                //           text2: "3500 دع",
                //         );
                //       }),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
