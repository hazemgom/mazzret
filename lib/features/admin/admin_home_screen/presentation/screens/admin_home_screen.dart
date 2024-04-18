import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/managers/admin_home_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/bannner/banner-admin-screen.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/category/details_category.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/product/details_product.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/product/edite_to_product.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/widget/custom_container.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_banner.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_category.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_product.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/navigation.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

import '../../../../../utils/custom_widgets/admin-product-widget.dart';
import '../products-screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> image = [
      AppAssets.product1,
      AppAssets.product2,
      AppAssets.product3,
    ];
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getBanners()
        ..getProductInHighSold()
        ..getCategoryList(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);

          return BlocConsumer<AdminHomeCubit, AdminHomeState>(
            listener: (context, state) {
              if (state is DeleteAllImagesInBannerSuccessState) {
                print('-------Deleted----------');
                BlocProvider.of<HomeCubit>(context).getBanners();
                return CustomSnackBar.showMessage(
                  context,
                  message: 'تمت عملية المسح بنجاح',
                  messageColor: AppColors.primaryColor,
                );
              } else if (state is DeleteAllImagesInBannerErrorState) {
                return CustomSnackBar.showMessage(
                  context,
                  message: 'حدثت مشكلة أثناء مسح اللافتة',
                  messageColor: Colors.red,
                );
              }
            },
            builder: (context, state) {
              var adminHomeCubit = AdminHomeCubit.get(context);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12)),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProductsScreen();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'اضافة منتج الي البانر',
                                style: GoogleFonts.tajawal(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12)),
                            child: MaterialButton(
                              onPressed: () {
                                homeCubit.deleteBanners(context);
                                Navigator.pushNamed(
                                    context, RouteName.adminHomeLayoutRoute);
                              },
                              child: Text(
                                'مسح جميع البانر',
                                style: GoogleFonts.tajawal(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BannerAdminScreen(),

                    /// Categories
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.category,
                            style: AppFonts.primarytext.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.adminGetAllCategories);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.showmore,
                              style: AppFonts.primarytext
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),

                    state is GetAllCategoriesLoadingState
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
                                  itemCount:
                                      homeCubit.categoryModel!.data!.length,
                                  itemBuilder: (context, index) {
                                    String image = homeCubit.categoryModel!
                                        .data![index].image!.url!;
                                    String text = MyCache.getString(
                                                key: CacheKeys.lang) ==
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
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          FadePageRoute(
                                            builder: (context) =>
                                                AdminDetailsCategory(
                                              image: homeCubit.categoryModel!
                                                  .data![index].image!.url!,
                                              namear: homeCubit
                                                  .categoryModel!
                                                  .data![index]
                                                  .nameAr! ,
                                              name:  homeCubit
                                                  .categoryModel!
                                                  .data![index]
                                                  .name!,
                                              text: text,
                                              createdAt: homeCubit
                                                  .categoryModel!
                                                  .data![index]
                                                  .createdAt!,
                                              updatedAt: homeCubit
                                                  .categoryModel!
                                                  .data![index]
                                                  .updatedAt!,
                                              categoryId: homeCubit
                                                  .categoryModel!
                                                  .data![index]
                                                  .sId!,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),

                    /// Products
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.featuredproducts,
                            style: AppFonts.primarytext.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.getAllProduct);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.showmore,
                              style: AppFonts.primarytext
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),

                    state is GetProductHighNySoldLoadingState ||
                            homeCubit.productModel == null
                        ? Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: const CustomLoading(),
                          )
                        : homeCubit.productModel!.data!.isEmpty
                            // ? Text('Empty')
                            ? Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: const CustomLoading(),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.1.h,
                                ),
                                itemCount: homeCubit.productModel!.data!.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return EditToProduct(
                                            title: homeCubit.productModel!.data![index].title!,
                                           priceWholesale: homeCubit.productModel!.data![index].priceWholesale!,
                                            description: homeCubit.productModel!.data![index].description!,
                                            descriptionAr: homeCubit.productModel!.data![index].descriptionAr!,
                                            priceNormal: homeCubit.productModel!.data![index].priceNormal!,
                                            quantity: homeCubit.productModel!.data![index].quantity!,
                                            titleAr: homeCubit.productModel!.data![index].titleAr!,

                                            productId: homeCubit.productModel!.data![index].sId!,

                                          );

                                        }));
                                      },
                                      child: CustomProductAdmin(
                                          cubit: homeCubit,
                                          model: homeCubit
                                              .productModel!.data![index],
                                          width: 180.w,
                                          image: homeCubit.productModel!
                                              .data![index].image!.url!,
                                          text1: MyCache.getString(
                                                      key: CacheKeys.lang) ==
                                                  'ar'
                                              ? homeCubit.productModel!
                                                  .data![index].titleAr!
                                              : homeCubit.productModel!
                                                  .data![index].title!,
                                          text2:
                                              '${MyCache.getString(key: CacheKeys.role) == 'user-normal' ? homeCubit.productModel!.data![index].priceNormal : homeCubit.productModel!.data![index].priceWholesale} ${AppLocalizations.of(context)!.egp}'),
                                    ),
                                  );
                                }),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
