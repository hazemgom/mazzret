import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/managers/admin_home_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/category/details_category.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_category.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/navigation.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class AdminGetAllCategories extends StatefulWidget {
  const AdminGetAllCategories({Key? key}) : super(key: key);

  @override
  State<AdminGetAllCategories> createState() => _AdminGetAllCategoriesState();
}

class _AdminGetAllCategoriesState extends State<AdminGetAllCategories> {
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    HomeCubit.get(context).getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: isSearching == false
            ? Text(
                AppLocalizations.of(context)!.category,
                style: AppFonts.titleScreen.copyWith(height: 0),
              )
            : BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  var categoryCubit = HomeCubit.get(context);

                  return TextFormField(
                    autofocus: true,
                    cursorColor: AppColors.grey,
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: AppColors.white,
                    ),
                    onChanged: (value) {
                      categoryCubit.searchCategory(
                        searchedText: value,
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
                            categoryCubit.searchCategoryList.clear();
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
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is CreateCategorySuccessState) {
            HomeCubit.get(context).getCategoryList();
          }
        },
        builder: (context, state) {
          var categoryCubit = HomeCubit.get(context);
          var categoryList = categoryCubit.categoryModel;

          return categoryList == null ||
                  categoryList.data == null ||
                  categoryList.data!.isEmpty
              ? const Center(
                  child: CustomLoading(),
                )
              : GridView.builder(
                  itemCount: categoryCubit.searchCategoryList.isEmpty
                      ? categoryList.data!.length
                      : categoryCubit.searchCategoryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.9.h,
                  ),
                  primary: false,
                  padding: EdgeInsets.all(10.sp),
                  itemBuilder: (context, index) {
                    return CustomCategory(
                      image: categoryCubit.searchCategoryList.isEmpty
                          ? categoryList.data![index].image!.url!
                          : categoryCubit.searchCategoryList[index].image!.url!,
                      text: MyCache.getString(key: CacheKeys.lang) == 'en'
                          ? categoryCubit.searchCategoryList.isEmpty
                              ? categoryList.data![index].name!
                              : categoryCubit.searchCategoryList[index].name!
                          : categoryCubit.searchCategoryList.isEmpty
                              ? categoryList.data![index].nameAr ??
                                  categoryList.data![index].name!
                              : categoryCubit
                                      .searchCategoryList[index].nameAr ??
                                  categoryCubit.searchCategoryList[index].name!,
                      onTap: () {
                        Navigator.push(
                          context,
                          FadePageRoute(
                            builder: (context) => AdminDetailsCategory(
                              image: categoryList.data![index].image!.url!,
                              name:categoryList.data![index].name! ,
                              namear: categoryList.data![index].nameAr!,
                              text:
                                  MyCache.getString(key: CacheKeys.lang) == 'ar'
                                      ? categoryList.data![index].nameAr!
                                      : categoryList.data![index].name!,
                              createdAt: categoryCubit
                                  .categoryModel!.data![index].createdAt!,
                              updatedAt: categoryCubit
                                  .categoryModel!.data![index].updatedAt!,
                              categoryId: categoryCubit
                                  .categoryModel!.data![index].sId!,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, RouteName.adminAddNewCategory);
        },
      ),
    );
  }
}

// CustomDetailsProductInWishList(
//   icon: Container(),
//   image: categoryCubit
//       .productsInCategoryModel!
//       .data![index]
//       .image!
//       .url!,
//   text: MyCache.getString(
//               key: CacheKeys.lang) ==
//           'ar'
//       ? categoryCubit
//           .productsInCategoryModel!
//           .data![index]
//           .titleAr!
//       : categoryCubit
//           .productsInCategoryModel!
//           .data![index]
//           .title!,
//   text2: MyCache.getString(
//               key: CacheKeys.lang) ==
//           'ar'
//       ? categoryCubit
//           .productsInCategoryModel!
//           .data![index]
//           .descriptionAr!
//       : categoryCubit
//           .productsInCategoryModel!
//           .data![index]
//           .description!,
//   text3: MyCache.getString(
//               key: CacheKeys.lang) ==
//           'ar'
//       ? categoryCubit
//               .productsInCategoryModel!
//               .data![index]
//               .category!
//               .nameAr ??
//           categoryCubit
//               .productsInCategoryModel!
//               .data![index]
//               .category!
//               .name!
//       : categoryCubit
//           .productsInCategoryModel!
//           .data![index]
//           .category!
//           .name!,
//   review: '',
//   text4: '',
//   widgetAddToCart: InkWell(
//     overlayColor:
//         MaterialStateProperty.all(
//       AppColors.primaryColor
//           .withOpacity(0.2),
//     ),
//     onTap: () {
//       // print(categoryCubit.productsInCategoryModel!.data![index].sId);
//       // categoryCubit
//       //     .productsInCategoryModel!
//       //     .data![index].id!;
//       categoryCubit.addToCart(
//         productId: categoryCubit
//             .productsInCategoryModel!
//             .data![index]
//             .id!,
//       );
//     },
//     child: Row(
//       mainAxisAlignment:
//           MainAxisAlignment.center,
//       children: [
//         Text(
//           '${AppLocalizations.of(context)!.addtocart}.',
//           style: AppFonts.descInWishList
//               .copyWith(
//             color:
//                 AppColors.primaryColor,
//             fontWeight: FontWeight.w800,
//             decoration: TextDecoration
//                 .underline,
//             fontSize: 16.sp,
//           ),
//           overflow:
//               TextOverflow.ellipsis,
//         ),
//       ],
//     ),
//   ),
// ),
