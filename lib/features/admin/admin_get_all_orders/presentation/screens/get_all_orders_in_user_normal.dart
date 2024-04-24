import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/data/models/all_orders_in_model.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/managers/admin_order_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_orders/presentation/widgets/custom_get_order_from_user.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class GetAllOrdersInUserNormalInManager extends StatelessWidget {
  const GetAllOrdersInUserNormalInManager({Key? key}) : super(key: key);

  String formattedDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat.yMMMMd().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.allorders,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
              create: (context) => AdminOrderCubit()
                ..getAllOrdersInBranchUserNormalFunction(role: 'user-normal'),
              child: BlocConsumer<AdminOrderCubit, AdminOrderState>(
                listener: (context, state) {
                  if (state is MakeConfirmOrderLoadingSuccessState) {
                    AdminOrderCubit.get(context)
                        .getAllOrdersInAdminFunction(role: 'user-normal');
                    CustomSnackBar.showMessage(
                      context,
                      message: 'تم تغيير حالة الاوردر',
                      messageColor: AppColors.primaryColor,
                    );
                  }
                },
                builder: (context, state) {
                  var adminOrderCubit = AdminOrderCubit.get(context);

                  return adminOrderCubit.getListOfOrdersInAdminAndInManager ==
                              null ||
                          state is GetAllOrdersInAdminLoadingState
                      ? const Center(
                          child: CustomLoading(),
                        )
                      : adminOrderCubit
                              .getListOfOrdersInAdminAndInManager!.data!.isEmpty
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
                                    horizontal: 10.w, vertical: 10.h),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                                          orderNumber: 1,
                                          id: order.orderNumber.toString(),
                                          date: formattedDate(order.createdAt!),
                                          name: order.user!.name ?? 'NULL',
                                          phone: order.user!.phone ?? 'NULL',
                                          state: order.status ?? 'NULL',
                                          buttonText: order.status ==
                                                  'in-progress'
                                              ? AppLocalizations.of(context)!
                                                  .confirm
                                              : AppLocalizations.of(context)!
                                                  .approved,
                                          confirmColor:
                                              order.status == 'in-progress'
                                                  ? AppColors.primaryColor
                                                  : Colors.green,
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              RouteName.detailsOrder,
                                              arguments: order.sId,
                                            );
                                          },
                                          onTapInConfirm: () {
                                            adminOrderCubit.makeConfirmOrder(
                                              orderId: order.sId!,
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
            ),
    );
  }
}

/*----------------------------------------------------*/
class GetAllOrdersInUserNormalInAdmin extends StatelessWidget {
  const GetAllOrdersInUserNormalInAdmin({Key? key}) : super(key: key);

  String formattedDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat.yMMMMd().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.allorders,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => AdminOrderCubit()
          ..getAllOrdersInAdminFunction(role: 'user-normal'),
        child: BlocConsumer<AdminOrderCubit, AdminOrderState>(
          listener: (context, state) {
            if (state is MakeConfirmOrderLoadingSuccessState) {
              AdminOrderCubit.get(context)
                  .getAllOrdersInAdminFunction(role: 'user-normal');
              CustomSnackBar.showMessage(
                context,
                message: 'تم تغيير حالة الاوردر',
                messageColor: AppColors.primaryColor,
              );
            }
          },
          builder: (context, state) {
            var adminOrderCubit = AdminOrderCubit.get(context);

            return adminOrderCubit.getListOfOrdersInAdminAndInManager ==
                null ||
                state is GetAllOrdersInAdminLoadingState
                ? const Center(
              child: CustomLoading(),
            )
                : adminOrderCubit
                .getListOfOrdersInAdminAndInManager!.data!.isEmpty
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
                    horizontal: 10.w, vertical: 10.h),
                child: Column(
                  children: [
                    ListView.builder(
                      physics:
                      const NeverScrollableScrollPhysics(),
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
                          orderNumber: 1,
                          id: order.orderNumber.toString(),
                          date: formattedDate(order.createdAt!),
                          name: order.user!.name ?? 'NULL',
                          phone: order.user!.phone ?? 'NULL',
                          state: order.status ?? 'NULL',
                          buttonText: order.status ==
                              'in-progress'
                              ? AppLocalizations.of(context)!
                              .confirm
                              : AppLocalizations.of(context)!
                              .approved,
                          confirmColor:
                          order.status == 'in-progress'
                              ? AppColors.primaryColor
                              : Colors.green,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteName.detailsOrder,
                              arguments: order.sId,
                            );
                          },
                          onTapInConfirm: () {
                            adminOrderCubit.makeConfirmOrder(
                              orderId: order.sId!,
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
      ),
    );
  }
}

