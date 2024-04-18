import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/home_layout/cart/managers/user_cart_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'widget/custom_previous_adress.dart';

class AllAddressesScreen extends StatelessWidget {
  const AllAddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String address;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.showAllAddressesBranches,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<UserCartCubit, UserCartState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cartCubit = UserCartCubit.get(context);

          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.showAllAddresses,
                      style: GoogleFonts.cairo(
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
              state is GetAllBranchesLoadingState
                  ? const Center(
                      child: CustomLoading(),
                    )
                  : cartCubit.getAllBranches == null
                      ? const Text('Empty')
                      : Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cartCubit.getAllBranches!.data!.length,
                            itemBuilder: (context, index) {
                              address =
                                  cartCubit.getAllBranches!.data![index].name!;
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 10.h),
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomPreviousAdress(
                                          phone: cartCubit.getAllBranches!
                                              .data![index].phone,
                                          city: cartCubit.getAllBranches!
                                              .data![index].name,
                                          details:
                                              '${cartCubit.getAllBranches!.data![index].address} ${cartCubit.getAllBranches!.data![index].lng} ${cartCubit.getAllBranches!.data![index].lat.toString()}',
                                          alias: cartCubit
                                              .getAllBranches!.data![index].lat
                                              .toString(),
                                          postCode: cartCubit.getAllBranches!
                                              .data![index].name,
                                          onTap: () {
                                            print(cartCubit.getAllBranches!
                                                .data![index].lng);
                                            print(cartCubit.getAllBranches!
                                                .data![index].lat);
                                            Map data = {
                                              'address': cartCubit
                                                  .getAllBranches!
                                                  .data![index]
                                                  .name,
                                              'lat': cartCubit.getAllBranches!
                                                  .data![index].lng,
                                              'lng': cartCubit.getAllBranches!
                                                  .data![index].lat,
                                              'name': cartCubit.getAllBranches!
                                                  .data![index].name,
                                              'phone': cartCubit.getAllBranches!
                                                  .data![index].phone,
                                            };

                                            Navigator.pushNamed(
                                              context,
                                              RouteName.locationInMap,
                                              arguments: data,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      left: 5.w,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                          border: Border.all(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              cartCubit.addressDataModel
                                                      .branchName =
                                                  cartCubit.getAllBranches!
                                                      .data![index].name;
                                              cartCubit.addressDataModel
                                                      .branchId =
                                                  cartCubit.getAllBranches!
                                                      .data![index].sId;
                                              Navigator.pushReplacementNamed(
                                                context,
                                                RouteName.previousAdressRoute,
                                              );
                                              // Navigator.pop(context);
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: AppColors.primaryColor,
                                              size: 26.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
            ],
          );
        },
      ),
    );
  }
}
