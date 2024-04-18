import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/widget/custom_product_in_cart.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/managers/profile_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetSpecificOrder extends StatelessWidget {
  String? orderId;


  GetSpecificOrder({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit()..getSpecificOrderFunction(orderId: orderId!),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          var orderCubit = ProfileCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              title: Text(
                AppLocalizations.of(context)!.orderDetails,
                style: AppFonts.titleScreen.copyWith(height: 0),
              ),
              centerTitle: true,
            ),
            body: state is GetSpecificOrderLoadingState
                ? const Center(
                    child: CustomLoading(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        orderCubit.specificOrderModel == null
                            ? const Text('Empty')
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                constraints: BoxConstraints(
                                  minHeight: 180.h,
                                  maxHeight: 600.h,
                                ),
                                child: ListView.builder(
                                    itemCount: orderCubit.specificOrderModel!
                                        .data!.cartItems!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Container(
                                          height: 200.h,
                                          width: 335.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            border: Border.all(
                                              width: 0.2.w,
                                              color: AppColors.grey,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 16.w,
                                                  right: 16.w,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          '${orderCubit.specificOrderModel!.data!.totalOrderPrice!} ${AppLocalizations.of(context)!.egp}',
                                                          style:
                                                              GoogleFonts.cairo(
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 100.w,
                                                          child: Text(
                                                            MyCache.getString(key: CacheKeys.lang) == 'ar' ? orderCubit
                                                                .specificOrderModel!
                                                                .data!
                                                                .cartItems![
                                                                    index]
                                                                .product!
                                                                .titleAr! :  orderCubit
                                                                .specificOrderModel!
                                                                .data!
                                                                .cartItems![
                                                            index]
                                                                .product!
                                                                .title!,
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: GoogleFonts.cairo(
                                                                fontSize: 20.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 110.w,
                                                      child: Text(
                                                        MyCache.getString(key: CacheKeys.lang) == 'ar' ? orderCubit
                                                            .specificOrderModel!
                                                            .data!
                                                            .cartItems![index]
                                                            .product!
                                                            .category!
                                                            .nameAr! : orderCubit
                                                            .specificOrderModel!
                                                            .data!
                                                            .cartItems![index]
                                                            .product!
                                                            .category!
                                                            .name!,
                                                        textAlign:
                                                            TextAlign.end,
                                                        style:
                                                            GoogleFonts.cairo(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 80.w,
                                                      child: Text(
                                                        // "${newCount ?? widget.test}",
                                                        "${AppLocalizations.of(context)!.quan} ${orderCubit.specificOrderModel!.data!.cartItems![index].quantity}",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style:
                                                            GoogleFonts.cairo(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 150.w,
                                                      child: Text(
                                                        // "${newCount ?? widget.test}",
                                                        "${AppLocalizations.of(context)!.status}: ${orderCubit.specificOrderModel!.data!.status == 'in-progress' ?  AppLocalizations.of(context)!.confirm : AppLocalizations.of(context)!.progress}",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style:
                                                            GoogleFonts.cairo(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 160.w,
                                                      child: Text(
                                                        // "${newCount ?? widget.test}",
                                                        orderCubit.specificOrderModel!.data!.isDelivered == true ? AppLocalizations.of(context)!.delivered : AppLocalizations.of(context)!.notDelivered,
                                                        textAlign:
                                                        TextAlign.end,
                                                        style:
                                                        GoogleFonts.cairo(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: AppColors
                                                              .primaryColor,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 165.h,
                                                width: 127.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      8.r,
                                                    ),
                                                    border: Border.all(
                                                        width: 0.2.w,
                                                        color: AppColors.grey)),
                                                child: CachedImage(
                                                  link: orderCubit
                                                      .specificOrderModel!
                                                      .data!
                                                      .cartItems![index]
                                                      .product!
                                                      .image!
                                                      .url!,
                                                  fit: BoxFit.fill,
                                                  borderRadius: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
