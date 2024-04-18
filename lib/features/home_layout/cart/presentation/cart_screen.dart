import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/managers/user_cart_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/widget/custom_empty_cart.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/widget/custom_product_in_cart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CartScreen extends StatefulWidget {
  int counter = 1;

  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int? newCount;

  @override
  void initState() {
    context.read<UserCartCubit>().getAllUserCartFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> image = [
      AppAssets.product1,
      AppAssets.product2,
      AppAssets.product3,
      AppAssets.product1,
    ];

    return BlocConsumer<UserCartCubit, UserCartState>(
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

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.primaryColor,
            title: Text(
              // currentIndex == 1
              //     ? AppLocalizations.of(context)!.mypersonalfile
              //     :
              AppLocalizations.of(context)!.mozart,
              style: AppFonts.banadoraText,
            ),
            leading: IconButton(
              onPressed: () async {
                await userCartCubit.deleteAllProductsFromCart();
              },
              icon: SvgPicture.asset(
                AppAssets.deleteIcon2,
                color: Colors.white,
                height: 28.h,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child:

                userCartList == null ||
                        userCartList.data == null ||
                        userCartList.data!.cartItems == null ||
                        userCartList.data!.cartItems!.isEmpty
                    ? const CustomEmptyWashlist()
                    : Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              minHeight: 180.h,
                              maxHeight: 600.h,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 15.h),
                                  ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        userCartList.data!.cartItems!.length,
                                    separatorBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20.w,
                                          vertical: 5.h,
                                        ),
                                        child: Divider(
                                          color: Colors.grey[400],
                                          thickness: 0.6.w,
                                        ),
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return CustomProductInCart(
                                        index: index,
                                        image: userCartList.data!
                                            .cartItems![index].product!.image!,
                                        text: MyCache.getString(
                                                    key: CacheKeys.lang) ==
                                                'ar'
                                            ? '${userCartList.data!.cartItems![index].product!.titleAr!} - ${userCartList.data!.cartItems![index].product!.descriptionAr} - ${userCartList.data!.cartItems![index].quantity}'
                                            : '${userCartList.data!.cartItems![index].product!.title!} - ${userCartList.data!.cartItems![index].product!.description} - ${userCartList.data!.cartItems![index].quantity}',
                                        text2: MyCache.getString(
                                                    key: CacheKeys.lang) ==
                                                'ar'
                                            ? userCartList
                                                .data!
                                                .cartItems![index]
                                                .product!
                                                .descriptionAr!
                                            : userCartList
                                                .data!
                                                .cartItems![index]
                                                .product!
                                                .description!,
                                        text3: userCartList
                                            .data!.cartItems![index].price
                                            .toString(),
                                        test: userCartList.data!
                                                .cartItems![index].quantity ??
                                            1,
                                        counter: userCartList
                                            .data!.cartItems![index].quantity,
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 5.h,
                                    ),
                                    child: Divider(
                                      color: Colors.grey[400],
                                      thickness: 0.6.w,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.summary,
                                        style: GoogleFonts.cairo(
                                          color: Colors.black87,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .countOfProducts
                                            .toString(),
                                        style: GoogleFonts.cairo(
                                          color: Colors.black87,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        userCartList.data!.cartItems!.length
                                            .toString(),
                                        style: GoogleFonts.cairo(
                                          color: AppColors.grey,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .priceOfAllProducts,
                                        style: GoogleFonts.cairo(
                                          color: Colors.black87,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '${userCartList.data!.totalCartPrice.toString()} ${AppLocalizations.of(context)!.egp}',
                                        style: GoogleFonts.cairo(
                                          color: AppColors.grey,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .priceOfDelivery,
                                        style: GoogleFonts.cairo(
                                          color: Colors.black87,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.free,
                                        style: GoogleFonts.cairo(
                                          color: AppColors.grey,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .totalPrice,
                                        style: GoogleFonts.cairo(
                                          color: Colors.black87,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${userCartCubit.userCartModel!.data!.totalCartPrice} ${AppLocalizations.of(context)!.egp}',
                                            style: GoogleFonts.cairo(
                                              color: AppColors.grey,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              CustomButtonWidget(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteName.previousAdressRoute,
                                    arguments: userCartList.data!.user!.address,
                                    // userCartList.data!.totalCartPrice,
                                  );
                                },
                                text: AppLocalizations.of(context)!.next,
                                height: 48.h,
                                width: 200,
                              ),
                              const Spacer(),
                              Text(
                                '${userCartList.data!.totalCartPrice} ${AppLocalizations.of(context)!.egp}',
                                style: GoogleFonts.cairo(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
          ),
        );
      },
    );
  }
}
