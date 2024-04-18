import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/managers/profile_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/edit_profile_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/custom_container_my_account.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/styles/fonts.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

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
    // List<String> name = [
    //   "Amira Adel",
    //   "amira@gmail.com",
    //   "01061489546",
    //   "*******",
    //   "streetname",
    //   "apartment",
    //   "zipcountry",
    //   "city",
    //   "country",
    // ];
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var profileCubit = ProfileCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
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
          // body: ListView.builder(
          //   itemCount: title.length,
          //     itemBuilder: (context,index ){
          //       return CustomContainerMyAccount(titleText: title[index], name: name[index]);
          //     }
          //
          // )
          body: profileCubit.profileDataModel == null ||
              profileCubit.profileDataModel!.data == null
              ? const Center(
            child: CustomLoading(),
          )
              : SingleChildScrollView(
            child: Column(
              children: [
                CustomContainerMyAccount(
                  titleText: title[0],
                  name: profileCubit.profileDataModel!.data!.name!,
                ),
                CustomContainerMyAccount(
                  titleText: title[1],
                  name: profileCubit.profileDataModel!.data!.email!,
                ),
                CustomContainerMyAccount(
                  titleText: title[2],
                  name: '*******',
                ),
                CustomContainerMyAccount(
                  titleText: title[3],
                  name: profileCubit.profileDataModel!.data!.phone!,
                ),
                CustomContainerMyAccount(
                  titleText: title[4],
                  name: profileCubit.profileDataModel!.data!.lat!.toString(),
                ),
                CustomContainerMyAccount(
                  titleText: title[5],
                  name: profileCubit.profileDataModel!.data!.lng!.toString(),
                ),
                CustomContainerMyAccount(
                  titleText: title[6],
                  name: profileCubit.profileDataModel!.data!.address!,
                ),
                // CustomContainerMyAccount(
                //   titleText: title[7],
                //   name: profileCubit.profileDataModel!.data!.city!,
                // ),
                // CustomContainerMyAccount(
                //   titleText: title[8],
                //   name: profileCubit.profileDataModel!.data!.country!,
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
