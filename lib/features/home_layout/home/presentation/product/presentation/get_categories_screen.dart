import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/home/data/models/products_in_category.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/presentation/products_in_category_screen.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_category.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/navigation.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetCategoriesScreen extends StatefulWidget {
  const GetCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<GetCategoriesScreen> createState() => _GetCategoriesScreenState();
}

class _GetCategoriesScreenState extends State<GetCategoriesScreen> {
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
        title:isSearching == false
            ? Text(
          AppLocalizations.of(context)!.categories,
          style: AppFonts.banadoraText,
        ) : BlocBuilder<HomeCubit, HomeState>(
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
      body: BlocBuilder<HomeCubit, HomeState>(
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
                    // return CustomCategory(image: image[index], text: text[index]);
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
                      // image: categoryList.data![index].image!.url!,
                      // text: MyCache.getString(key: CacheKeys.lang) == 'ar'
                      //     ? categoryList.data![index].nameAr ??
                      //     categoryList.data![index].name!
                      //     : categoryList.data![index].name!,
                      onTap: () {
                        Map map = {
                          'categoryId': categoryCubit.categoryModel!.data![index].sId,
                          'index': index,
                        };
                        print(map['index']);

                        Navigator.pushNamed(
                          context,
                          RouteName.productsInCategoryScreenRoute,
                          arguments: map,
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
