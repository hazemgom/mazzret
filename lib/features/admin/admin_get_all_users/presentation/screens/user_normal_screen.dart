import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/managers/get_all_users_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/presentation/widgets/custom_get_user.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class UserNormalScreen extends StatelessWidget {
  const UserNormalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.userNormal,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.adminHomeLayoutRoute,
                  (route) {
                return false;
              },
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocProvider(
        create: (context) => GetAllUsersCubit()..getAllUsersFunction(role: 'user-normal'),
        child: BlocBuilder<GetAllUsersCubit, GetAllUsersState>(
          builder: (context, state) {
            var allUsersCubit = GetAllUsersCubit.get(context);

            return Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: state is GetAllUsersLoadingState
                      ? const Center(
                          child: CustomLoading(),
                        )
                      : allUsersCubit.managerUsersModel == null ||
                              allUsersCubit.managerUsersModel!.data!.isEmpty
                          ? const Text('Empty Users')
                          : ListView.builder(
                              itemCount:
                                  allUsersCubit.managerUsersModel!.data!.length,
                              itemBuilder: (context, index) {
                                var user =
                                    allUsersCubit.managerUsersModel!.data![index];

                                return CustomGetUser(
                                  name: user.name!,
                                  phone: user.phone!,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteName.detailsUser,
                                      arguments: allUsersCubit.managerUsersModel!.data![index].sId,
                                    );
                                  },
                                );
                              },
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
