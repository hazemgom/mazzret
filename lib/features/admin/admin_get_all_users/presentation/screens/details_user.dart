import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/data/models/get_all_users_model.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/managers/get_all_users_cubit.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_back_for_app.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsUser extends StatelessWidget {
  // Data? allUsersModel;
  String id;

  DetailsUser({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isActivate = false;

    return BlocProvider(
      create: (context) =>
          GetAllUsersCubit()..getSpecificUserOrAdminOrManagerFunction(id: id),
      child: BlocConsumer<GetAllUsersCubit, GetAllUsersState>(
        listener: (context, state) {
          var usersCubit = GetAllUsersCubit.get(context);

          if (state is MakeUserActivateErrorState) {
            return CustomSnackBar.showMessage(
              context,
              message: 'حدثت مشكلة أثناء التفعيل',
              messageColor: Colors.red,
            );
          } else if (state is MakeUserActivateSuccessState) {

            Navigator.pop(context);

            // usersCubit.getAllUsersFunction(role: 'user-wholesale');
          }

          if (state is DeleteOneAdminOrManagerSuccessState) {
            GetAllUsersCubit.get(context)
                .getSpecificUserOrAdminOrManagerFunction(
                id: usersCubit.specificUserModel!.data!.sId!);
            // Navigator.pop(context);
            // Navigator.pop(context);
            //   Navigator.pushReplacementNamed(
            //       context, RouteName.adminHomeLayoutRoute);
            //   BlocProvider.of<GetAllUsersCubit>(context).getAllUsersFunction(role: 'manager');
            //   BlocProvider.of<GetAllUsersCubit>(context).getAllUsersFunction(role: 'admin');
            //   return CustomSnackBar.showMessage(
            //     context,
            //     message: 'تم الحذف بنجاح',
            //     messageColor: AppColors.primaryColor,
            //   );
          }
          // else
          if (state is DeleteOneAdminOrManagerErrorState) {
            return CustomSnackBar.showMessage(
              context,
              message: 'حدثت مشكلة أثناء الحذف',
              messageColor: Colors.red,
            );
          }
          if (state is UpdateSpecificUserSuccessState) {
            GetAllUsersCubit.get(context)
                .getSpecificUserOrAdminOrManagerFunction(
                    id: usersCubit.specificUserModel!.data!.sId!);
          }
        },
        builder: (context, state) {
          var usersCubit = GetAllUsersCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              title: usersCubit.specificUserModel == null
                  ? Text('....')
                  : Text(
                      usersCubit.specificUserModel!.data!.role == 'user-normal'
                          ? AppLocalizations.of(context)!.userNormal
                          : usersCubit.specificUserModel!.data!.role ==
                                  'user-wholesale'
                              ? AppLocalizations.of(context)!.userWholesale
                              : usersCubit.specificUserModel!.data!.role ==
                                      'manager'
                                  ? AppLocalizations.of(context)!.manager
                                  : AppLocalizations.of(context)!.admin,
                      style: AppFonts.titleScreen.copyWith(
                        height: 0,
                      ),
                    ),
              centerTitle: true,
              actions: usersCubit.specificUserModel == null
                  ? []
                  : [
                      MyCache.getString(key: CacheKeys.userId) ==
                              usersCubit.specificUserModel!.data!.sId
                          ? IconButton(
                              onPressed: () {
                                Map<String, dynamic> map = {
                                  'userId':
                                      usersCubit.specificUserModel!.data!.sId,
                                  'lat':
                                      usersCubit.specificUserModel!.data!.lat,
                                  'lng':
                                      usersCubit.specificUserModel!.data!.lng,
                                  'address': usersCubit
                                      .specificUserModel!.data!.address,
                                };
                                Navigator.pushNamed(
                                  context,
                                  RouteName.editUserRoute,
                                  arguments: map,
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 18.sp,
                              ),
                            )
                          : MyCache.getString(key: CacheKeys.role) == 'manager'
                              // &&
                              //     MyCache.getString(key: CacheKeys.userId) ==
                              //         usersCubit.specificUserModel!.data!.sId
                              ? Container()
                              : usersCubit.specificUserModel!.data!.role ==
                                          'user-normal' ||
                                      usersCubit.specificUserModel!.data!.role ==
                                          'user-wholesale'
                                  ? Container()
                                  : IconButton(
                                      onPressed: () {
                                        Map<String, dynamic> map = {
                                          'userId': usersCubit
                                              .specificUserModel!.data!.sId,
                                          'lat': usersCubit
                                              .specificUserModel!.data!.lat,
                                          'lng': usersCubit
                                              .specificUserModel!.data!.lng,
                                          'address': usersCubit
                                              .specificUserModel!.data!.address,
                                        };
                                        Navigator.pushNamed(
                                          context,
                                          RouteName.editUserRoute,
                                          arguments: map,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 18.sp,
                                      ),
                                    ), // : Container(),
                      MyCache.getString(key: CacheKeys.role) == 'manager'
                          ? Container()
                          : IconButton(
                              onPressed: () {
                                showAdaptiveDialog(
                                  context: context,
                                  builder: (context) => CustomBackForAppBar(
                                    text: MyCache.getString(
                                                key: CacheKeys.role) ==
                                            'admin'
                                        ? '${AppLocalizations.of(context)!.doyouwantdeletethis} ${AppLocalizations.of(context)!.admin}'
                                        : '${AppLocalizations.of(context)!.doyouwantdeletethis} ${AppLocalizations.of(context)!.manager}',
                                    onPressed: () {
                                      usersCubit.deleteUserFunction(
                                          id: usersCubit.specificUserModel!.data!.sId!).then((value) {
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          usersCubit.specificUserModel!.data!.role ==
                                              'user-normal' ?  RouteName.userNormalRoute : RouteName.userWholesaleRoute,
                                          (route) {
                                            return false;
                                          },
                                        );
                                      });
                                    },
                                    text2: AppLocalizations.of(context)!.submit,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.delete_forever_rounded,
                                color: AppColors.white,
                                size: 24.sp,
                              ),
                            ),
                    ],
            ),
            body: usersCubit.specificUserModel == null
                ? const Center(
                    child: CustomLoading(),
                  )
                : Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50.r,
                              backgroundColor: AppColors.primaryColor,
                              child: Center(
                                child: Icon(
                                  Icons.perm_identity,
                                  color: AppColors.white,
                                  size: 40.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              usersCubit.specificUserModel!.data!.name!,
                              style:
                                  AppFonts.black2Text.copyWith(fontSize: 16.sp),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            state is MakeUserActivateLoadingState
                                ? CustomLoading()
                                : usersCubit.specificUserModel!.data!.active!
                                    ? Container()
                                    : CustomButtonWidget(
                                        onPressed: () {
                                          // print(usersCubit
                                          //     .specificUserModel!.data!.sId!);
                                          usersCubit.makeUserActivate(
                                              userId: usersCubit
                                                  .specificUserModel!
                                                  .data!
                                                  .sId!);
                                        },
                                        borderRadius: 18.r,
                                        text: 'أجعله مفعل',
                                        height:
                                            MediaQuery.of(context).size.height /
                                                18,
                                      ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.name,
                                      style: GoogleFonts.cairo(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Text(
                                      usersCubit.specificUserModel!.data!.name!,
                                      style: GoogleFonts.cairo(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1.w,
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.phonenumber,
                                      style: GoogleFonts.cairo(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Text(
                                      usersCubit
                                          .specificUserModel!.data!.phone!,
                                      style: GoogleFonts.cairo(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1.w,
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.email,
                                      style: GoogleFonts.cairo(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Text(
                                      usersCubit
                                          .specificUserModel!.data!.email!,
                                      style: GoogleFonts.cairo(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1.w,
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.lng,
                                      style: GoogleFonts.cairo(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Text(
                                      usersCubit.specificUserModel!.data!.lng
                                          .toString(),
                                      style: GoogleFonts.cairo(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1.w,
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.lat,
                                      style: GoogleFonts.cairo(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Text(
                                      usersCubit.specificUserModel!.data!.lat
                                          .toString(),
                                      style: GoogleFonts.cairo(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1.w,
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.address,
                                      style: GoogleFonts.cairo(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Text(
                                        usersCubit
                                            .specificUserModel!.data!.address!,
                                        style: GoogleFonts.cairo(
                                          color: AppColors.grey,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1.w,
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.isActivate,
                                      style: GoogleFonts.cairo(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Text(
                                        usersCubit.specificUserModel!.data!
                                                .active!
                                            ? AppLocalizations.of(context)!.yes
                                            : AppLocalizations.of(context)!.no,
                                        style: GoogleFonts.cairo(
                                          color: AppColors.grey,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteName.locationInMap,
                                    arguments: {
                                      'lat': usersCubit
                                          .specificUserModel!.data!.lat,
                                      'lng': usersCubit
                                          .specificUserModel!.data!.lng,
                                      'address': usersCubit
                                          .specificUserModel!.data!.address,
                                      'phone': usersCubit
                                          .specificUserModel!.data!.phone,
                                      'name': usersCubit
                                          .specificUserModel!.data!.name,
                                      'email': usersCubit
                                          .specificUserModel!.data!.email,
                                    });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .locationindetailInMaps,
                                        style: GoogleFonts.cairo(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .locationindetailInMaps,
                                        style: AppFonts.greyText.copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    AppAssets.locationIcon,
                                    color: AppColors.primaryColor,
                                    height: 30.h,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
