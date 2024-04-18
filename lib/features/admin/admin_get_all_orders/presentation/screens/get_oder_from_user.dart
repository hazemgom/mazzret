// ignore_for_file: use_build_context_synchronously

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/data/models/all_orders_in_model.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/managers/admin_order_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/presentation/widgets/custom_get_order_from_user.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';

class GetOrderFromUser extends StatelessWidget {
  const GetOrderFromUser({Key? key}) : super(key: key);

  String formattedDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat.yMMMMd().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return
      // MyCache.getString(key: CacheKeys.role) == 'manager'
      //   ?
    Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: 50.h),
              Text(
                AppLocalizations.of(context)!
                    .choosethetypeofcustomertodisplayAllOrders,
                style: GoogleFonts.cairo(
                  height: 1.h,
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 40.w, right: 40.w, bottom: 20.h, top: 100.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.userNormalOrdersRouteAdmin,
                    );
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(8.r),
                    color: AppColors.primaryColor,
                    child: Container(
                      width: double.infinity,
                      height: 100.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grey.withOpacity(0.01),
                            offset: const Offset(1, 1),
                            blurRadius: 10.r,
                            spreadRadius: 0.1.r,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.userNormal,
                            style: GoogleFonts.cairo(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              height: 1.h,
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18.sp,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 20.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.userWholesaleOrdersRouteAdmin,
                    );
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(8.r),
                    color: AppColors.primaryColor,
                    child: Container(
                      width: double.infinity,
                      height: 100.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grey.withOpacity(0.01),
                            offset: const Offset(1, 1),
                            blurRadius: 10.r,
                            spreadRadius: 0.1.r,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.userWholesale,
                            style: GoogleFonts.cairo(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              height: 1.h,
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18.sp,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        // :
      // BlocProvider(
      //       create: (context) =>
      //           AdminOrderCubit()..getAllOrdersInAdminFunction(),
      //       child: BlocConsumer<AdminOrderCubit, AdminOrderState>(
      //         listener: (context, state) async {
      //           if (state is MakeConfirmOrderLoadingSuccessState) {
      //             await AdminOrderCubit.get(context)
      //                 .getAllOrdersInAdminFunction();
      //             CustomSnackBar.showMessage(
      //               context,
      //               message: 'تم تغيير حالة الاوردر',
      //               messageColor: AppColors.primaryColor,
      //             );
      //           }
      //         },
      //         builder: (context, state) {
      //           var adminOrderCubit = AdminOrderCubit.get(context);
      //
      //           return adminOrderCubit.getListOfOrdersInAdminAndInManager ==
      //                   null
      //               ? const Center(
      //                   child: CustomLoading(),
      //                 )
      //               : adminOrderCubit
      //                       .getListOfOrdersInAdminAndInManager!.data!.isEmpty
      //                   ? Center(
      //                       child: Text(
      //                         'No orders yet',
      //                         style: GoogleFonts.cairo(
      //                             color: Colors.black,
      //                             fontSize: 22.sp,
      //                             fontWeight: FontWeight.w600),
      //                       ),
      //                     )
      //                   : SingleChildScrollView(
      //                       child: Padding(
      //                         padding: EdgeInsets.symmetric(
      //                             horizontal: 10.w, vertical: 10.h),
      //                         child: Column(
      //                           children: [
      //                             ListView.builder(
      //                               physics:
      //                                   const NeverScrollableScrollPhysics(),
      //                               shrinkWrap: true,
      //                               itemCount: adminOrderCubit
      //                                   .getListOfOrdersInAdminAndInManager!
      //                                   .data!
      //                                   .length,
      //                               itemBuilder: (context, index) {
      //                                 OrderData order = adminOrderCubit
      //                                     .getListOfOrdersInAdminAndInManager!
      //                                     .data![index];
      //
      //                                 return CustomGetOrderFromUser(
      //                                   orderNumber: 1,
      //                                   id: order.orderNumber.toString(),
      //                                   date: formattedDate(order.createdAt!),
      //                                   name: order.user!.name ?? 'NULL',
      //                                   phone: order.user!.phone ?? 'NULL',
      //                                   state: order.status == 'in-progress'
      //                                       ? AppLocalizations.of(context)!
      //                                       .progress
      //                                       : AppLocalizations.of(context)!
      //                                       .approved,
      //                                   buttonText:
      //                                       order.status == 'in-progress'
      //                                           ? AppLocalizations.of(context)!
      //                                               .progress
      //                                           : AppLocalizations.of(context)!
      //                                               .approved,
      //                                   confirmColor:
      //                                       order.status == 'in-progress'
      //                                           ? AppColors.primaryColor
      //                                           : Colors.green,
      //                                   onTap: () {
      //                                     Navigator.pushNamed(
      //                                       context,
      //                                       RouteName.detailsOrder,
      //                                       arguments: order.sId,
      //                                     );
      //                                   },
      //                                   onTapInConfirm:
      //                                       order.status == 'in-progress'
      //                                           ? () {
      //                                               adminOrderCubit
      //                                                   .makeConfirmOrder(
      //                                                 orderId: order.sId!,
      //                                               );
      //                                             }
      //                                           : null,
      //                                 );
      //                               },
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     );
      //         },
      //       ),
      //     );
  }
}

/*
class GetOrderFromUser extends StatelessWidget {
  const GetOrderFromUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyCache.getString(key: CacheKeys.role) == 'admin'
          ? BlocProvider(
              create: (context) =>
                  AdminOrderCubit()..getAllOrdersInAdminFunction(),
              child: BlocBuilder<AdminOrderCubit, AdminOrderState>(
                builder: (context, state) {
                  var adminOrderCubit = AdminOrderCubit.get(context);

                  return adminOrderCubit.getListOfOrdersInAdminAndInManager ==
                          null
                      ? const Center(
                          child: Text('No Orders'),
                        )
                      : state is GetAllOrdersInAdminLoadingState
                          ? const Center(
                              child: CustomLoading(),
                            )
                          : SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: adminOrderCubit
                                          .getListOfOrdersInAdminAndInManager!
                                          .data!
                                          .length,
                                      itemBuilder: (context, index) {
                                        OrderData order = adminOrderCubit
                                            .getListOfOrdersInAdminAndInManager!
                                            .data![index];

                                        return CustomGetOrderFromUser(
                                          name: order.user!.name ?? 'NULL',
                                          phone: order.user!.phone ?? 'NULL',
                                          state: order.status ?? 'NULL',
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              RouteName.detailsOrder,
                                              arguments: order,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    // Expanded(
                                    //   child: ListView.builder(
                                    //   itemCount: 2,
                                    //   itemBuilder: (context,index){
                                    //     return CustomGetOrderFromUser(name: "اميره عادل محمد", phone: "01061489546", state: "Delivered");
                                    //
                                    //   }),
                                    // )
                                  ],
                                ),
                              ),
                            );
                },
              ),
            )
          : BlocProvider(
              create: (context) => AdminOrderCubit()
                ..getAllOrdersInManagerFunction(
                    branchId: MyCache.getString(key: CacheKeys.userId)!),
              child: BlocBuilder<AdminOrderCubit, AdminOrderState>(
                builder: (context, state) {
                  var managerOrderCubit = AdminOrderCubit.get(context);

                  return managerOrderCubit.getListOfOrdersInAdminAndInManager ==
                          null
                      ? Center(
                          child: Text('No Orders'),
                        )
                      : state is GetAllOrdersInManagerLoadingState
                          ? Center(
                              child: CustomLoading(),
                            )
                          : SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: managerOrderCubit
                                          .getListOfOrdersInAdminAndInManager!
                                          .data!
                                          .length,
                                      itemBuilder: (context, index) {
                                        var order = managerOrderCubit
                                            .getListOfOrdersInAdminAndInManager!
                                            .data![index];

                                        return CustomGetOrderFromUser(
                                          name: order.user!.name!,
                                          phone: order.user!.phone!,
                                          state: order.status!,
                                          onTap: () {},
                                        );
                                      },
                                    ),
                                    // Expanded(
                                    //   child: ListView.builder(
                                    //   itemCount: 2,
                                    //   itemBuilder: (context,index){
                                    //     return CustomGetOrderFromUser(name: "اميره عادل محمد", phone: "01061489546", state: "Delivered");
                                    //
                                    //   }),
                                    // )
                                  ],
                                ),
                              ),
                            );
                },
              ),
            ),
    );
  }
}

 */
