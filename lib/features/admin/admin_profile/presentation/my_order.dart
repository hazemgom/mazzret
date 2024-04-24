// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:mozart_flutter_app/config/app_assets.dart';
// import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/custom_container_my_order.dart';
// import 'package:mozart_flutter_app/utils/custom_widgets/custom_empty.dart';
// import 'package:mozart_flutter_app/utils/styles/colors.dart';
// import 'package:mozart_flutter_app/utils/styles/fonts.dart';
//
// class MyOrderScreen extends StatefulWidget {
//   const MyOrderScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MyOrderScreen> createState() => _MyOrderScreenState();
// }
//
// class _MyOrderScreenState extends State<MyOrderScreen>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//
//   @override
//   void initState() {
//     _tabController = TabController(length: 3, vsync: this);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _tabController!.dispose();
//   }
//
//   String formattedDate(String dateTimeString) {
//     DateTime dateTime = DateTime.parse(dateTimeString);
//     return DateFormat.yMMMMd().format(dateTime);
//   }
//
//   String formattedTime(String dateTimeString) {
//     DateTime dateTime = DateTime.parse(dateTimeString);
//     return DateFormat.jm().format(dateTime);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primaryColor,
//         title: Text(
//           AppLocalizations.of(context)!.myrequests,
//           style: AppFonts.titleScreen.copyWith(height: 0),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // give the tab bar a height [can change hheight to preferred height]
//           TabBar(
//             indicatorColor: Colors.black,
//             controller: _tabController,
//             // give the indicator a decoration (color and border radius)
//             labelColor: Colors.black,
//             unselectedLabelColor: Colors.black,
//             tabs: [
//               Tab(
//                 text:  AppLocalizations.of(context)!.allorders,
//               ),
//               Tab(
//                 text:  AppLocalizations.of(context)!.currentorders,
//
//               ),
//               Tab(
//                 text:  AppLocalizations.of(context)!.previousorders,
//
//               ),
//             ],
//           ),
//           // tab bar view here
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 // first tab bar view widget
//                SingleChildScrollView(
//                  child: Column(
//                    children: [
//                      SizedBox(height: 20.h,),
//                      CustomContainerMyOrder(
//                        date: formattedDate(orderList.data![index].createdAt.toString()),
//                        text: AppLocalizations.of(context)!.delivered, color: Colors.green, paymentMethod: '', statusOfOrder: '', statusColor: Colors.green, onTap: () {  },),
//                      CustomContainerMyOrder(text: AppLocalizations.of(context)!.canceled, color: Colors.red, paymentMethod: '', statusOfOrder: '', statusColor: Colors.green, onTap: () {  },),
//                    ],
//                  ),
//                ),
//                CustomEmpty(image: AppAssets.order2Icon, text: AppLocalizations.of(context)!.therearenorequestsyet,
//          textButton:AppLocalizations.of(context)!.startbrowsing, onTap: () {  }, ),
//                 SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(height: 20.h,),
//                       CustomContainerMyOrder(text: AppLocalizations.of(context)!.delivered, color: Colors.red, paymentMethod: '', statusOfOrder: '', statusColor: Colors.green, onTap: () {  },),
//                       CustomContainerMyOrder(text: AppLocalizations.of(context)!.canceled, color: Colors.red, paymentMethod: '', statusOfOrder: '', statusColor: Colors.green, onTap: () {  },),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
