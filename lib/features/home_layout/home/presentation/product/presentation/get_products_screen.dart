import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/presentation/details_product.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/widget/custom_details_product.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/navigation.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class GetProductsScreen extends StatefulWidget {
  const GetProductsScreen({Key? key}) : super(key: key);

  @override
  State<GetProductsScreen> createState() => _GetProductsScreenState();
}

class _GetProductsScreenState extends State<GetProductsScreen> {
  bool isSearching = false;

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
                        ),
                      ),
                    ),
                  );
                },
              ),
        centerTitle: true,
        actions: [
          isSearching == true
              ? Container()
              : IconButton(
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
                            onTap: () {
                              Navigator.push(
                                context,
                                FadePageRoute(
                                  builder: (context) => DetailsProduct(
                                    productId: productCubit
                                        .productModel!.data![index].id,
                                  ),
                                ),
                              );
                            },
                            child: CustomDetailsProductInWishList(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.primaryColor,
                              ),
                              quantity: productCubit
                                  .productModel!.data![index].quantity!,
                              image: productCubit.searchProductList.isEmpty
                                  ? productCubit
                                      .productModel!.data![index].image!.url!
                                  : productCubit
                                      .searchProductList[index].image!.url!,
                              text:
                                  MyCache.getString(key: CacheKeys.lang) == 'ar'
                                      ? productCubit.searchProductList.isEmpty
                                          ? productCubit.productModel!
                                              .data![index].titleAr!
                                          : productCubit
                                              .searchProductList[index].titleAr!
                                      : productCubit.searchProductList.isEmpty
                                          ? productCubit
                                              .productModel!.data![index].title!
                                          : productCubit
                                              .searchProductList[index].title!,
                              text2: MyCache.getString(key: CacheKeys.lang) == 'ar'
                                      ? productCubit.searchProductList.isEmpty
                                          ? productCubit.productModel!
                                              .data![index].descriptionAr!
                                          : productCubit
                                              .searchProductList[index]
                                              .descriptionAr!
                                      : productCubit.searchProductList.isEmpty
                                          ? productCubit.productModel!
                                              .data![index].description ?? "description"
                                          : productCubit
                                              .searchProductList[index]
                                              .description ?? 'User',
                              text3:
                                  MyCache.getString(key: CacheKeys.lang) == 'ar'
                                      ? productCubit.searchProductList.isEmpty
                                          ? productCubit.productModel!
                                              .data![index].category!.nameAr
                                              .toString()
                                          : productCubit
                                              .searchProductList[index]
                                              .category!
                                              .nameAr!
                                      : productCubit.searchProductList.isEmpty
                                          ? productCubit.productModel!
                                              .data![index].category!.name!
                                          : productCubit
                                              .searchProductList[index]
                                              .category!
                                              .name!,
                              review: '',
                              text4: '',
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
