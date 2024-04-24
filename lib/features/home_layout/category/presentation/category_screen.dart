import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getCategoryList(),
      child: BlocBuilder<HomeCubit, HomeState>(
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
                  itemCount: categoryList.data!.length,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.9.h,
                  ),
                  primary: false,
                  padding: EdgeInsets.all(10.sp),
                  itemBuilder: (context, index) {
                    // return CustomCategory(image: image[index], text: text[index]);
                    return CustomCategory(
                      image: categoryList.data![index].image!.url!,
                      text: MyCache.getString(key: CacheKeys.lang) == 'ar'
                          ? categoryList.data![index].nameAr ??
                          categoryList.data![index].name!
                          : categoryList.data![index].name!,
                      onTap: () {
                        Map map = {
                          'categoryId': categoryCubit.categoryModel!.data![index].sId,
                          'index': index,
                        };

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
