import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/managers/profile_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/custom_container_my_order.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_empty.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int orderNumber = 1;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }


  String formattedDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat.yMMMMd().format(dateTime);
  }

  String formattedTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat.jm().format(dateTime);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.myrequests,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit()..getOrdersFunction(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            var orderCubit = ProfileCubit.get(context);
            var orderList = orderCubit.orderModel;

            return Column(
              children: [
                // give the tab bar a height [can change hheight to preferred height]
                TabBar(
                  indicatorColor: Colors.black,
                  controller: _tabController,
                  // give the indicator a decoration (color and border radius)
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: AppLocalizations.of(context)!.allorders,
                    ),
                    Tab(
                      text: AppLocalizations.of(context)!.currentorders,
                    ),
                    Tab(
                      text: AppLocalizations.of(context)!.previousorders,
                    ),
                  ],
                ),
                // tab bar view here
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // first tab bar view widget
                      state is GetOrdersLoadingState
                          ? const Center(
                              child: CustomLoading(),
                            )
                          : orderList == null || orderList.data!.isEmpty
                              ? CustomEmpty(
                                  image: AppAssets.order2Icon,
                                  text: AppLocalizations.of(context)!
                                      .therearenorequestsyet,
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, RouteName.homeLayoutRoute);
                                  },
                                  textButton: AppLocalizations.of(context)!
                                      .startbrowsing)
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: orderList.data!.length,
                                        itemBuilder: (context, index) {
                                          return CustomContainerMyOrder(
                                            orderNumber: orderNumber++,
                                            id: orderList.data![index].orderNumber!.toString(),
                                            date:'${formattedTime(orderList.data![index].createdAt.toString())} - ${formattedDate(orderList.data![index].createdAt.toString())}',
                                            text:
                                                '${orderList.data![index].totalOrderPrice} ${AppLocalizations.of(context)!.egp}',
                                            paymentMethod:
                                                '${orderList.data![index].paymentMethod! == 'cash' ? AppLocalizations.of(context)!.cash : ''}, ${orderList.data![index].cartItems!.length} ${AppLocalizations.of(context)!.product}',
                                            // AppLocalizations.of(context)!.delivered,
                                            color: Colors.green,
                                            statusOfOrder:orderList.data![index].status ==
                                                'in-progress'
                                                ?AppLocalizations.of(context)!
                                                .progress :
                                            AppLocalizations.of(context)!
                                                .confirm,
                                            statusColor:
                                                orderList.data![index].status ==
                                                        'in-progress'
                                                    ? Colors.orangeAccent
                                                    : Colors.green,
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                RouteName.getSpecificOrderRoute,
                                                arguments:
                                                    orderList.data![index].sId!,
                                              );
                                            },
                                          );
                                        },
                                      )
                                      // CustomContainerMyOrder(
                                      //     text: orderList.data![]
                                      //         // AppLocalizations.of(context)!.delivered,
                                      //     color: Colors.green),
                                      // CustomContainerMyOrder(
                                      //     text:
                                      //         AppLocalizations.of(context)!.canceled,
                                      //     color: Colors.red),
                                    ],
                                  ),
                                ),
                      CustomEmpty(
                          image: AppAssets.order2Icon,
                          text: AppLocalizations.of(context)!
                              .therearenorequestsyet,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, RouteName.homeLayoutRoute);
                          },
                          textButton:
                              AppLocalizations.of(context)!.startbrowsing),
                      state is GetOrdersLoadingState
                          ? const Center(
                              child: CustomLoading(),
                            )
                          : orderList == null || orderList.data!.isEmpty
                              ? CustomEmpty(
                                  image: AppAssets.order2Icon,
                                  text: AppLocalizations.of(context)!
                                      .therearenorequestsyet,
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, RouteName.homeLayoutRoute);
                                  },
                                  textButton: AppLocalizations.of(context)!
                                      .startbrowsing)
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: orderList.data!.length,
                                        itemBuilder: (context, index) {
                                          return CustomContainerMyOrder(
                                            orderNumber: orderNumber++,
                                            id: orderList.data![index].orderNumber!.toString(),
                                            date: formattedDate(orderList.data![index].createdAt.toString()),
                                            text:
                                                '${orderList.data![index].totalOrderPrice} ${AppLocalizations.of(context)!.egp}',
                                            paymentMethod:
                                            '${orderList.data![index].paymentMethod! == 'cash' ? AppLocalizations.of(context)!.cash : ''}, ${orderList.data![index].cartItems!.length} ${AppLocalizations.of(context)!.product}',
                                            color: Colors.green,
                                            statusOfOrder: orderList.data![index].status ==
                                                'in-progress'
                                                ?AppLocalizations.of(context)!
                                                .progress :
                                                AppLocalizations.of(context)!
                                                .confirm,
                                            statusColor:
                                                orderList.data![index].status ==
                                                        'in-progress'
                                                    ? Colors.orangeAccent
                                                    : Colors.green,
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                RouteName.getSpecificOrderRoute,
                                                arguments:
                                                    orderList.data![index].sId!,
                                              );
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
