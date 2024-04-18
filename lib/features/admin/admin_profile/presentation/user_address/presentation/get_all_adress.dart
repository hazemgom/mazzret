import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/managers/get_all_users_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widget/custom_get_adress.dart';

class AdminGetAllAddress extends StatelessWidget {
  const AdminGetAllAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.primaryColor,
      //   onPressed: () {
      //     Navigator.pushNamed(context, RouteName.addAddressOfBranch);
      //   },
      //   child: Icon(
      //     Icons.add,
      //     color: AppColors.white,
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.branches,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<GetAllUsersCubit, GetAllUsersState>(
        builder: (context, state) {
          var allManagersCubit = GetAllUsersCubit.get(context);

          return state is GetAllManagersLoadingState ||
              allManagersCubit.managerUsersModel == null
              ? const Center(
            child: CustomLoading(),
          )
              : allManagersCubit.managerUsersModel!.data!.isEmpty
              ? Text('Empty')
              : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 10.w, vertical: 20.h),
              child: Column(
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allManagersCubit
                          .managerUsersModel!.data!.length,
                      itemBuilder: (context, index) {
                        return CustomGetAddress(
                            name: allManagersCubit
                                .managerUsersModel!.data![index].name!,
                            address: allManagersCubit.managerUsersModel!
                                .data![index].address!,
                            phone: allManagersCubit
                                .managerUsersModel!.data![index].phone!,
                            email: allManagersCubit
                                .managerUsersModel!.data![index].email!,
                            onTap: () {
                              Map<String, dynamic> map = {
                                'name': allManagersCubit
                                    .managerUsersModel!.data![index].name,
                                'lat': allManagersCubit
                                    .managerUsersModel!.data![index].lat,
                                'lng': allManagersCubit
                                    .managerUsersModel!.data![index].lng,
                                'address': allManagersCubit
                                    .managerUsersModel!.data![index].address,
                              };
                              Navigator.pushNamed(
                                  context, RouteName.locationInMap, arguments: map);
                            }
                          // "${AppLocalizations.of(context)!.zipcountry} ${AppLocalizations.of(context)!.country} ${AppLocalizations.of(context)!.city} ${AppLocalizations.of(context)!.streetname} ${AppLocalizations.of(context)!.apartment}",
                        );
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
