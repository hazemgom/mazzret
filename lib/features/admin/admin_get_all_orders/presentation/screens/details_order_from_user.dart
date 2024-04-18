import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/data/models/all_orders_in_model.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/managers/admin_order_cubit.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class DetailsOrderFromUser extends StatelessWidget {
  String? orderId;

  DetailsOrderFromUser({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdminOrderCubit()..getSpecificOrderInAdminFunction(orderId: orderId!),
      child: BlocBuilder<AdminOrderCubit, AdminOrderState>(
        builder: (context, state) {
          var orderCubit = AdminOrderCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.orderDetails,
                style: AppFonts.titleScreen.copyWith(height: 0),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    // print(orderData!.sId);
                    Navigator.pushNamed(
                      context,
                      RouteName.editeToOrderData,
                      arguments: orderCubit.specificOrderModel!.data!.sId,
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 18.sp,
                  ),
                ),
              ],
            ),
            body: orderCubit.specificOrderModel == null
                ? Center(
                    child: CustomLoading(),
                  )
                : orderCubit.specificOrderModel!.data == null ||
                        orderCubit.specificOrderModel!.data!.cartItems!.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No orders yet',
                              style: GoogleFonts.cairo(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Lottie.asset('assets/lotties/empty.json',
                                height: 120.h),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.userDetails} :-',
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ],
                              ),

                              /// User Data
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 15.h),
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: MyCache.getString(
                                                key: CacheKeys.lang) ==
                                            'ar'
                                        ? 20.w
                                        : 0,
                                    left: MyCache.getString(
                                                key: CacheKeys.lang) ==
                                            'en'
                                        ? 20.w
                                        : 0,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '- ${AppLocalizations.of(context)!.name}: ',
                                            style: GoogleFonts.cairo(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              orderCubit.specificOrderModel!
                                                  .data!.user!.name!,
                                              style: GoogleFonts.cairo(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: Divider(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '- ${AppLocalizations.of(context)!.email}: ',
                                            style: GoogleFonts.cairo(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              orderCubit.specificOrderModel!
                                                  .data!.user!.email!,
                                              style: GoogleFonts.cairo(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: Divider(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '- ${AppLocalizations.of(context)!.phonenumber}: ',
                                            style: GoogleFonts.cairo(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              orderCubit.specificOrderModel!
                                                  .data!.user!.phone!,
                                              style: GoogleFonts.cairo(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: Divider(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '- ${AppLocalizations.of(context)!.typeOfUser}: ',
                                            style: GoogleFonts.cairo(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              orderCubit.specificOrderModel!
                                                          .data!.user!.role ==
                                                      'user-normal'
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .userNormal
                                                  : AppLocalizations.of(
                                                          context)!
                                                      .userWholesale,
                                              style: GoogleFonts.cairo(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: Divider(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '- ${AppLocalizations.of(context)!.lat}: ',
                                            style: GoogleFonts.cairo(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              orderCubit.specificOrderModel!
                                                  .data!.user!.lat
                                                  .toString(),
                                              style: GoogleFonts.cairo(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: Divider(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '- ${AppLocalizations.of(context)!.lng}: ',
                                            style: GoogleFonts.cairo(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              orderCubit.specificOrderModel!
                                                  .data!.user!.lng
                                                  .toString(),
                                              style: GoogleFonts.cairo(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: Divider(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      InkWell(
                                        overlayColor: MaterialStateProperty.all(
                                          AppColors.primaryColor
                                              .withOpacity(0.2),
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            RouteName.locationInMap,
                                            arguments: {
                                              'address': orderCubit
                                                  .specificOrderModel!
                                                  .data!
                                                  .user!
                                                  .address!,
                                              'lat': orderCubit
                                                  .specificOrderModel!
                                                  .data!
                                                  .user!
                                                  .lat!,
                                              'lng': orderCubit
                                                  .specificOrderModel!
                                                  .data!
                                                  .user!
                                                  .lng!,
                                              'name': orderCubit
                                                  .specificOrderModel!
                                                  .data!
                                                  .user!
                                                  .name!,
                                              'phone': orderCubit
                                                  .specificOrderModel!
                                                  .data!
                                                  .user!
                                                  .phone!,
                                            },
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              '- ${AppLocalizations.of(context)!.locationindetailInMaps}: ',
                                              style: GoogleFonts.cairo(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      orderCubit
                                                          .specificOrderModel!
                                                          .data!
                                                          .user!
                                                          .address!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.cairo(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: MyCache.getString(
                                                                  key: CacheKeys
                                                                      .lang) ==
                                                              'ar'
                                                          ? 40.w
                                                          : 0,
                                                      right: MyCache.getString(
                                                                  key: CacheKeys
                                                                      .lang) ==
                                                              'en'
                                                          ? 40.w
                                                          : 0,
                                                    ),
                                                    child: SvgPicture.asset(
                                                      AppAssets.locationIcon,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 40.h),

                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.orderDetails} :-',
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.price}: ${orderCubit.specificOrderModel!.data!.totalOrderPrice} ${AppLocalizations.of(context)!.egp}',
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h),

                              /// User Order
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: orderCubit.specificOrderModel!.data!
                                    .cartItems!.length,
                                itemBuilder: (context, index) {
                                  var oneItem = orderCubit.specificOrderModel!
                                      .data!.cartItems![index];

                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    padding: EdgeInsets.only(
                                      right: MyCache.getString(
                                                  key: CacheKeys.lang) ==
                                              'ar'
                                          ? 20.w
                                          : 0,
                                      left: MyCache.getString(
                                                  key: CacheKeys.lang) ==
                                              'en'
                                          ? 20.w
                                          : 0,
                                    ),
                                    margin: EdgeInsets.only(bottom: 10.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${AppLocalizations.of(context)!.nameOfProduct}:',
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.cairo(
                                                      fontSize: 18.sp,
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(width: 10.w),
                                                SizedBox(
                                                  width: 60.w,
                                                  child: Text(
                                                    MyCache.getString(
                                                                key: CacheKeys
                                                                    .lang) ==
                                                            'ar'
                                                        ? oneItem
                                                            .product!.titleAr!
                                                        : oneItem
                                                            .product!.title!,
                                                    textAlign: TextAlign.end,
                                                    style: GoogleFonts.cairo(
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .categoryName,
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.cairo(
                                                      fontSize: 18.sp,
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  width: 50.w,
                                                  child: Text(
                                                    MyCache.getString(
                                                                key: CacheKeys
                                                                    .lang) ==
                                                            'ar'
                                                        ? oneItem.product!
                                                            .category!.nameAr!
                                                        : oneItem.product!
                                                            .category!.name!,
                                                    textAlign: TextAlign.end,
                                                    style: GoogleFonts.cairo(
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${AppLocalizations.of(context)!.price}: ',
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.cairo(
                                                      fontSize: 18.sp,
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  width: 120.w,
                                                  child: Text(
                                                    '${oneItem.price!.toString()} ${AppLocalizations.of(context)!.egp}',
                                                    textAlign: TextAlign.end,
                                                    style: GoogleFonts.cairo(
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .quan,
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.cairo(
                                                      fontSize: 18.sp,
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  width: 110.w,
                                                  child: Text(
                                                    oneItem.quantity!
                                                        .toString(),
                                                    textAlign: TextAlign.end,
                                                    style: GoogleFonts.cairo(
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 165.h,
                                          width: 130.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            border: Border.all(
                                                width: 0.2.w,
                                                color: AppColors.grey),
                                          ),
                                          child: CachedImage(
                                            link: oneItem.product!.image!.url!,
                                            fit: BoxFit.fill,
                                            borderRadius: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
          );
        },
      ),
    );
  }
}
