import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/managers/profile_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/edit_profile_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/custom_container_my_account.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/styles/fonts.dart';

class MyAccount extends StatelessWidget {
  MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> title = [
      AppLocalizations.of(context)!.name,
      AppLocalizations.of(context)!.email,
      AppLocalizations.of(context)!.password,
      AppLocalizations.of(context)!.phonenumber,
      AppLocalizations.of(context)!.lat,
      AppLocalizations.of(context)!.lng,
      AppLocalizations.of(context)!.address,
      // AppLocalizations.of(context)!.city,
      // AppLocalizations.of(context)!.country,
    ];
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfileData(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          var profileCubit = ProfileCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              elevation: 0,
              title: Text(
                AppLocalizations.of(context)!.myaccount,
                style: AppFonts.titleScreen.copyWith(height: 0),
              ),
              centerTitle: true,
              // actions: [
              // IconButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         PageRouteBuilder(
              //           transitionDuration: const Duration(milliseconds: 500),
              //           pageBuilder: (context, animation, secondaryAnimation) =>
              //               EditProfileScreen(
              //                 name: profileCubit.profileDataModel!.data!.name!,
              //                 email: profileCubit.profileDataModel!.data!.email!,
              //                 phone: profileCubit.profileDataModel!.data!.phone!,
              //                 // city: profileCubit.profileDataModel!.data!.city!,
              //                 // country: profileCubit.profileDataModel!.data!.country!,
              //                 // apartment: profileCubit.profileDataModel!.data!.apartment!,
              //                 // streetname: profileCubit.profileDataModel!.data!.street!,
              //                 // zipcode: profileCubit.profileDataModel!.data!.zip!,
              //                 lat: profileCubit.profileDataModel!.data!.lat,
              //                 lng: profileCubit.profileDataModel!.data!.lng,
              //                 address: profileCubit.profileDataModel!.data!.address!,
              //
              //               ),
              //           transitionsBuilder:
              //               (context, animation, secondaryAnimation, child) {
              //             return FadeTransition(
              //               opacity: animation,
              //               child: child,
              //             );
              //           },
              //         ),
              //       );
              //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen(
              //       //     name: name[0], email: name[1], phone: name[2], password: name[3], city: name[4], country: name[5], apartment: name[6], streetname: name[7], zipcode: name[8],),),);
              //     },
              //     icon: const Icon(Icons.edit_outlined))
              // ],
            ),
            body: profileCubit.profileDataModel == null
                ? const Center(
                    child: CustomLoading(),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title[1],
                            style: GoogleFonts.cairo(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                            ),
                          ),
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(242, 242, 242, 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: profileCubit
                                      .profileDataModel!.data!.email!,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  suffixIcon: const Icon(Icons.email),
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            title[0],
                            style: GoogleFonts.cairo(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                            ),
                          ),
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(242, 242, 242, 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: profileCubit
                                      .profileDataModel!.data!.name!,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  suffixIcon: const Icon(Icons.person),
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            title[2],
                            style: GoogleFonts.cairo(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                            ),
                          ),
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(242, 242, 242, 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                enabled: false,
                                decoration: const InputDecoration(
                                  hintText: '********',
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  suffixIcon: Icon(Icons.password),
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            title[3],
                            style: GoogleFonts.cairo(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                            ),
                          ),
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(242, 242, 242, 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: profileCubit
                                      .profileDataModel!.data!.phone!,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  suffixIcon: const Icon(Icons.call),
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            title[4],
                            style: GoogleFonts.cairo(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                            ),
                          ),
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(242, 242, 242, 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: profileCubit
                                      .profileDataModel!.data!.lat
                                      .toString()!,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  suffixIcon: const Icon(Icons.location_on),
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            title[5],
                            style: GoogleFonts.cairo(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                            ),
                          ),
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(242, 242, 242, 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: profileCubit
                                      .profileDataModel!.data!.lng
                                      .toString()!,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  suffixIcon: const Icon(Icons.location_on),
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            title[6],
                            style: GoogleFonts.cairo(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                            ),
                          ),
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(242, 242, 242, 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: profileCubit
                                      .profileDataModel!.data!.address
                                      .toString()!,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  suffixIcon: const Icon(Icons.location_city),
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
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
