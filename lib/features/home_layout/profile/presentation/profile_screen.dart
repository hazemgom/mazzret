import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/managers/profile_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/connect_with_us.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/my_account.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/my_order.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/custom_container_profile.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/show_language_bottom_shet.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/show_tell_us_about_your_experience_bottom_shet.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_back_for_app.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

TextEditingController controller = TextEditingController();

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> icon = [
      SvgPicture.asset(AppAssets.profileIcon),
      SvgPicture.asset(AppAssets.myorderIcon),
      // SvgPicture.asset(AppAssets.),
      // Icon(Icons.favorite_border, color: Colors.grey.shade300),
      SvgPicture.asset(AppAssets.locationIcon),
      // SvgPicture.asset(AppAssets.walletIcon),
      SvgPicture.asset(AppAssets.programmerIcon,
          width: 26.w, color: Colors.grey.shade600),
      SvgPicture.asset(AppAssets.earphonesIcon),
      SvgPicture.asset(AppAssets.textIcon),
      SvgPicture.asset(AppAssets.language),
      SvgPicture.asset(AppAssets.signoutIcon),
    ];
    List<String> text = [
      AppLocalizations.of(context)!.editprofile,
      AppLocalizations.of(context)!.myrequests,
      // AppLocalizations.of(context)!.myreviews,
      AppLocalizations.of(context)!.showAllAddressesBranches,
      // AppLocalizations.of(context)!.banadorawallet,
      AppLocalizations.of(context)!.programmer,
      AppLocalizations.of(context)!.connectwithus,
      AppLocalizations.of(context)!.tellusaboutyourexperience,
      AppLocalizations.of(context)!.language,
      AppLocalizations.of(context)!.signout,
    ];

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var profileCubit = ProfileCubit.get(context);

        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                CircleAvatar(
                  radius: 61.r,
                  backgroundColor: AppColors.primaryColor,
                  child: CircleAvatar(
                    radius: 53,
                    backgroundColor: AppColors.white,
                    child: CircleAvatar(
                      radius: 52.r,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(
                        Icons.person_2_outlined,
                        color: AppColors.white,
                        size: 40.sp,
                      ),
                    ),
                  ),
                ),
                Text(
                  profileCubit.profileDataModel == null
                      ? ''
                      : profileCubit.profileDataModel!.data!.name!,
                  style: GoogleFonts.cairo(fontSize: 18.sp, height: 2.h),
                ),
                Text(
                  profileCubit.profileDataModel == null
                      ? ''
                      : profileCubit.profileDataModel!.data!.email!,
                  style: AppFonts.bodyText.copyWith(fontSize: 15.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CustomContainerProfile(
                      icon: icon[index],
                      text: text[index],
                      onTap: () {
                        if (index == 0) {
                          Navigator.pushNamed(
                              context, RouteName.myAccountRoute);
                        } else if (index == 1) {
                          Navigator.pushNamed(context, RouteName.myOrderRoute);
                          // } else if (index == 2) {
                          //   Navigator.pushNamed(
                          //       context, RouteName.getMyReviewsRoute);
                        } else if (index == 2) {
                          Navigator.pushNamed(
                              context, RouteName.allAddressesInProfileRoute);
                        } else if (index == 3) {
                          Navigator.pushNamed(
                              context, RouteName.programmerRoute);
                        } else if (index == 4) {
                          Navigator.pushNamed(
                              context, RouteName.connectWithUsRoute);
                        } else if (index == 5) {
                          showTellUsAboutYourExperienceBottomSheet();
                        } else if (index == 7) {
                          showAdaptiveDialog(
                            context: context,
                            builder: (context) => CustomBackForAppBar(
                              text: AppLocalizations.of(context)!
                                  .doyouwanttologout,
                              onPressed: () {
                                MyCache.clearShared();
                                Navigator.pushReplacementNamed(
                                  context,
                                  RouteName.loginRoute,
                                );
                              },
                              text2: AppLocalizations.of(context)!.exit,
                            ),
                          );
                        } else {
                          showLanguageBottomSheet();
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 0.h,
                      ),
                      child: Divider(
                        thickness: 1.sp,
                      ),
                    );
                  },
                  itemCount: text.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        )),
        context: context,
        builder: (context) {
          return const ShowLnguageBottomShet();
        });
  }

// sendFeedBackToAdminFunction
  void showTellUsAboutYourExperienceBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r),
            topLeft: Radius.circular(20.r),
          ),
        ),
        context: context,
        builder: (context) {
          return ShowTellUsAboutYourExperienceBottomSheet(
            controller: controller,
          );
        });
  }
}
