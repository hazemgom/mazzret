import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/widget/custom_empty_cart.dart';
import 'package:mozart_flutter_app/features/home_layout/washlist/managers/wishlist_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/washlist/presentation/widget/wishlist_details.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_product.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/navigation.dart';

class WashListScreen extends StatefulWidget {
  const WashListScreen({Key? key}) : super(key: key);

  @override
  State<WashListScreen> createState() => _WashListScreenState();
}

class _WashListScreenState extends State<WashListScreen> {

  @override
  void initState() {
    WishlistCubit.get(context).getWishListFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> image = [
      AppAssets.product1,
      AppAssets.product2,
      AppAssets.product3,
      AppAssets.product3,
    ];
    return BlocConsumer<WishlistCubit, WishlistState>(
      listener: (context, state) {
        if(state is RemoveFromWishListSuccessState) {
          WishlistCubit.get(context).getWishListFunction();
        }
      },
      builder: (context, state) {
        var wishListCubit = WishlistCubit.get(context);
        var wishList = wishListCubit.wishListModel;

        return state is GetWishListLoadingState
            ? const Center(
                child: CustomLoading(),
              )
            : wishListCubit.wishListModel == null ||
                    wishList == null ||
                    wishList.data == null ||
                    wishList.data!.isEmpty
                ? const CustomEmptyWashlist()
                : GridView.builder(
                    itemCount: wishList.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    primary: false,
                    padding: EdgeInsets.all(20.sp),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            FadePageRoute(
                              builder: (context) => WishListDetailsScreen(
                                image: wishList.data![index].image!.url!,
                                categoryName: MyCache.getString(
                                            key: CacheKeys.lang) ==
                                        'ar'
                                    ? wishList
                                            .data![index].category!.nameAr ??
                                        wishList.data![index].category!.name
                                    : wishList.data![index].category!.name,
                                productName:
                                    MyCache.getString(key: CacheKeys.lang) ==
                                            'ar'
                                        ? wishList.data![index].titleAr
                                        : wishList.data![index].title!,
                                desc:
                                    MyCache.getString(key: CacheKeys.lang) ==
                                            'ar'
                                        ? wishList.data![index].descriptionAr!
                                        : wishList.data![index].description,
                                productId: wishList.data![index].sId!,
                              ),
                            ),
                          );
                        },
                        child: CustomProduct(
                          height: 160,
                          width: 155,
                          image: wishList.data![index].image!.url!,
                          text1:
                              MyCache.getString(key: CacheKeys.lang) == 'ar'
                                  ? wishList.data![index].titleAr!
                                  : wishList.data![index].title!,
                          // text1: AppLocalizations.of(context)!.helloketchup,
                          text2:
                              MyCache.getString(key: CacheKeys.lang) == 'ar'
                                  ? wishList.data![index].descriptionAr!
                                  : wishList.data![index].description!,
                        ),
                      );
                    },
                  );
      },
    );
  }
}
