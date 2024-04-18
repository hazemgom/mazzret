import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/managers/user_cart_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/presentation/widget/custom_previous_adress.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class PreviousAdress extends StatefulWidget {
  // int? totalPrice;
  String? address;

  PreviousAdress({
    Key? key,
    // required this.totalPrice,
    required this.address,
  }) : super(key: key);

  @override
  State<PreviousAdress> createState() => _PreviousAdressState();
}

class _PreviousAdressState extends State<PreviousAdress> {
  @override
  void dispose() {
    UserCartCubit.get(context).newPosition = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCartCubit, UserCartState>(
        listener: (context, state) {
      if (state is AddOrderSuccessState) {
        if (BlocProvider.of<UserCartCubit>(context)
                .userCartModel!
                .data!
                .user!
                .role ==
            'user-normal') {
          CustomSnackBar.showMessage(
            context,
            message: 'تم أضافة طلب جديد لك وسيتم الموافقة عليه من قبل الفرع',
            messageColor: AppColors.primaryColor,
          );

          BlocProvider.of<UserCartCubit>(context).deleteAllProductsFromCart();
          Navigator.pop(context);
        } else {
          CustomSnackBar.showMessage(
            context,
            message: 'تم أضافة طلب جديد لك بنجاح',
            messageColor: AppColors.primaryColor,
          );

          BlocProvider.of<UserCartCubit>(context).deleteAllProductsFromCart();
          Navigator.pop(context);
        }
      }
    }, builder: (context, state) {
      var cartCubit = UserCartCubit.get(context);

      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            AppLocalizations.of(context)!.order,
            style: AppFonts.titleScreen.copyWith(height: 0),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.previousadress,
                        style: GoogleFonts.cairo(
                          fontSize: 18.sp,
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pushNamed(
                      //       context,
                      //       RouteName.allMyAddressesRoute,
                      //     );
                      //   },
                      //   child: Text(
                      //     AppLocalizations.of(context)!.showmore,
                      //     style: GoogleFonts.cairo(
                      //       fontSize: 18.sp,
                      //       color: AppColors.primaryColor,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                cartCubit.userCartModel == null ||
                        state is GetAllUserCartLoadingState
                    ? const Center(
                        child: CustomLoading(),
                      )
                    : cartCubit.userCartModel!.data!.user == null
                        ? Container()
                        : CustomPreviousAdress(
                            phone: cartCubit.userCartModel!.data!.user!.phone,
                            city: cartCubit.userCartModel!.data!.user!.address,
                            details: cartCubit.newPosition == null
                                ? '${cartCubit.userCartModel!.data!.user!.lat}, ${cartCubit.userCartModel!.data!.user!.lng}, ${cartCubit.userCartModel!.data!.user!.address}'
                                    .toString()
                                : cartCubit.newPosition ?? 'Loa...',
                            alias: cartCubit.userCartModel!.data!.user!.lng
                                .toString(),
                            postCode:
                                cartCubit.userCartModel!.data!.user!.email,
                            onTap: () {
                              Navigator.pushNamed(context,
                                  RouteName.mapToSelectAnotherLocationRoute,
                                  arguments: {
                                    'name': cartCubit
                                        .userCartModel!.data!.user!.name,
                                    'lat': cartCubit
                                        .userCartModel!.data!.user!.lat,
                                    'lng': cartCubit
                                        .userCartModel!.data!.user!.lng,
                                    'address': cartCubit
                                        .userCartModel!.data!.user!.address,
                                  });
                            },
                          ),
                SizedBox(height: 20.h),
                // CustomButtonWidget(
                //   height: 48.h,
                //   width: 227.w,
                //   onPressed: () {
                //     Navigator.pushNamed(
                //         context, RouteName.addAdressToConfirmOrderRoute);
                //   },
                //   text: AppLocalizations.of(context)!.addnewadress,
                // ),
                SizedBox(height: 15.h),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.enterbranch,
                          style: GoogleFonts.cairo(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteName.allAddressesRoute,
                            );
                            // Navigator.pushNamed(
                            //   context,
                            //   RouteName.allAddressesRoute,
                            // );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.enterhere,
                            style: GoogleFonts.cairo(
                              decoration: TextDecoration.underline,
                              fontSize: 18.sp,
                              color: AppColors.primaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
                  child: Container(
                    height: 60.h,
                    padding: MyCache.getString(key: CacheKeys.lang) == 'ar'
                        ? EdgeInsets.only(right: 20.w)
                        : EdgeInsets.only(left: 20.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.2.w, color: AppColors.grey),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          // address == '' || address == null
                          //     ? AppLocalizations.of(context)!.enterInIcon
                          //     : address!,
                          cartCubit.addressDataModel.branchName ??
                              AppLocalizations.of(context)!.enterInIcon,
                          // cartCubit.getAllBranches!.data![0].name!,
                          style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.2.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                // CustomPaymentSummary(totalPrice: totalPrice),
                SizedBox(height: 10.h),
                // Text(
                //   AppLocalizations.of(context)!.reviewtherequest,
                //   style: AppFonts.primarytext,
                // ),
                // SizedBox(
                //   height: 10.h,
                // ),
                state is AddOrderLoadingState
                    ? const Center(
                        child: CustomLoading(),
                      )
                    : CustomButtonWidget(
                        onPressed: () {
                          String id = cartCubit.userCartModel!.data!.sId!;

                          if (cartCubit.addressDataModel.branchId == null ||
                              cartCubit.addressDataModel.branchName == null) {
                            CustomSnackBar.showMessage(
                              context,
                              message:
                                  'برجاء اختيار الفرع الذي سيتم عملية الشراء منه',
                              messageColor: Colors.orangeAccent,
                            );
                          } else {
                            cartCubit.addOrderFunction(
                              cartId: id,
                              branchId: cartCubit.addressDataModel.branchId!,
                            );
                          }

                          /// In Params
                        },
                        text: AppLocalizations.of(context)!.confirmOrder,
                        height: 48.h,
                        width: 227.w,
                      )
              ],
            ),
          ),
        ),
      );
    });
  }
}
