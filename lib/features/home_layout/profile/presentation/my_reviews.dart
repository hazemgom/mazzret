import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/widget/custom_empty_cart.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/widget/custom_product_in_cart.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/widget/custom_details_product.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/managers/profile_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyReviews extends StatelessWidget {
  const MyReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getAllReviews(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          var reviewsCubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              title: Text(
                AppLocalizations.of(context)!.myreviews,
                style: AppFonts.titleScreen.copyWith(height: 0),
              ),
              centerTitle: true,
            ),
            body: state is GetAllReviewsLoadingState
                ? const Center(
                    child: CustomLoading(),
                  )
                : reviewsCubit.myReviewsModel == null ||
                        reviewsCubit.myReviewsModel!.data!.isEmpty
                    ? const CustomEmptyWashlist()
                    : ListView.builder(
                        itemCount: reviewsCubit.myReviewsModel!.data!.length,
                        itemBuilder: (context, index) {
                          var item = reviewsCubit.myReviewsModel!.data![index];

                          return Center(
                            child: CustomDetailsProductInWishList(
                              image: item.product!.image!.url!,
                              text: item.product!.title!.toString(),
                              text2: item.user == null ? ' ' : item.user!.name!,
                              email: item.user == null ? ' ' : item.user!.email!,
                              phone: item.user == null ? ' ' : item.user!.phone!,
                              text3: item.product!.category!.name!.toString(),
                              review: AppLocalizations.of(context)!.review,
                              text4: item.ratings!,
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}
