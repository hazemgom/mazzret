import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/data/models/all_orders_in_model.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/managers/admin_order_cubit.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class EditToOrderData extends StatelessWidget {
  String? orderId;

  EditToOrderData({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdminOrderCubit()..getSpecificOrderInAdminFunction(orderId: orderId!),
      child: BlocConsumer<AdminOrderCubit, AdminOrderState>(
        listener: (context, state) {
          if (state is ChangeStatusOrderToPaidSuccessState ||
              state is ChangeStatusOrderToDeliverySuccessState) {
            // if (MyCache.getString(key: CacheKeys.role) == 'admin') {
            AdminOrderCubit.get(context)
                .getSpecificOrderInAdminFunction(orderId: orderId!);
            // } else if (MyCache.getString(key: CacheKeys.role) == 'manager') {
            //   AdminOrderCubit.get(context)
            //       .getAllOrdersInBranchUserNormalFunction(role: 'user-normal');
            //   AdminOrderCubit.get(context)
            //       .getAllOrdersInBranchUserNormalFunction(role: 'user-wholesale');
            // }
            // Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var editOrderCubit = AdminOrderCubit.get(context);

          return Directionality(
            textDirection: MyCache.getString(key: CacheKeys.lang) == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context)!.editToOrderData,
                  style: AppFonts.titleScreen.copyWith(height: 0),
                ),
              ),
              body:
                  // orderData == null
                  //     ? const Center(
                  //         child: CustomLoading(),
                  //       )
                  //     :
                  editOrderCubit.specificOrderModel == null
                      ? const Center(
                          child: CustomLoading(),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 30.h),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .paymentstatus,
                                      style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    editOrderCubit.specificOrderModel!.data!
                                                .isPaid ==
                                            false
                                        ? Expanded(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .notPaid,
                                              style: GoogleFonts.cairo(
                                                color: Colors.grey
                                                    .withOpacity(0.9),
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.clip,
                                            ),
                                          )
                                        : Text(
                                            AppLocalizations.of(context)!.paid,
                                            style: GoogleFonts.cairo(
                                              color: Colors.green,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.clip,
                                          )
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              editOrderCubit.specificOrderModel!.data!.isPaid ==
                                      false
                                  ? InkWell(
                                      onTap: () {
                                        editOrderCubit
                                            .changeStatusOrderToPaidFunction(
                                          orderId: editOrderCubit
                                              .specificOrderModel!.data!.sId!,
                                        );
                                        // print(orderData!.sId!);
                                      },
                                      overlayColor: MaterialStateProperty.all(
                                        AppColors.primaryColor.withOpacity(0.2),
                                      ),
                                      child: state
                                              is ChangeStatusOrderToPaidLoadingState
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Lottie.asset(
                                                  'assets/lotties/loading.json',
                                                  height: 80.h,
                                                  width: 80.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            )
                                          : DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(8.r),
                                              color: AppColors.primaryColor,
                                              child: Container(
                                                width: 120.w,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.w,
                                                    vertical: 6.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .change,
                                                      style: GoogleFonts.cairo(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .change_circle_outlined,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                    )
                                  : Container(),
                              SizedBox(height: 30.h),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .placeOfOrder,
                                      style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    editOrderCubit.specificOrderModel!.data!
                                                .isDelivered ==
                                            false
                                        ? Expanded(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .notDelivered,
                                              style: GoogleFonts.cairo(
                                                color: Colors.grey
                                                    .withOpacity(0.9),
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.clip,
                                            ),
                                          )
                                        : Text(
                                            AppLocalizations.of(context)!
                                                .delivered,
                                            style: GoogleFonts.cairo(
                                              color: AppColors.primaryColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.clip,
                                          )
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              editOrderCubit.specificOrderModel!.data!
                                          .isDelivered ==
                                      false
                                  ? InkWell(
                                      onTap: () {
                                        editOrderCubit
                                            .changeStatusOrderToDeliveryFunction(
                                          orderId: editOrderCubit
                                              .specificOrderModel!.data!.sId!,
                                        );
                                        // print(orderData!.sId!);
                                      },
                                      overlayColor: MaterialStateProperty.all(
                                        AppColors.primaryColor.withOpacity(0.2),
                                      ),
                                      child: state
                                              is ChangeStatusOrderToDeliveryLoadingState
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Lottie.asset(
                                                  'assets/lotties/loading.json',
                                                  height: 80.h,
                                                  width: 80.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            )
                                          : DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(8.r),
                                              color: AppColors.primaryColor,
                                              child: Container(
                                                width: 120.w,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.w,
                                                    vertical: 6.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .change,
                                                      style: GoogleFonts.cairo(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .change_circle_outlined,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                    )
                                  : Container(),
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
