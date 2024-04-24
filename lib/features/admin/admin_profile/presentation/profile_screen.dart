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
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/custom_container_profile.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/show_language_bottom_shet.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/show_tell_us_about_your_experience_bottom_shet.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_back_for_app.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({Key? key}) : super(key: key);

  @override
  State<AdminProfileScreen> createState() => _ProfileScreenState();
}

TextEditingController controller = TextEditingController();

class _ProfileScreenState extends State<AdminProfileScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> icon = [
      SvgPicture.asset(AppAssets.profileIcon),
      Icon(
        Icons.image_outlined,
        color: AppColors.grey2,
      ),
      SvgPicture.asset(AppAssets.locationIcon),
      // SvgPicture.asset(AppAssets.walletIcon),
      SvgPicture.asset(
        AppAssets.messageIcon,
        color: AppColors.grey2,
      ),
      SvgPicture.asset(AppAssets.textIcon),
      Icon(
        Icons.reviews_outlined,
        color: AppColors.grey2,
      ),
      SvgPicture.asset(AppAssets.language),
      SvgPicture.asset(AppAssets.signoutIcon),
    ];
    List<String> text = [
      AppLocalizations.of(context)!.editprofile,
      AppLocalizations.of(context)!.suggestedpictures,
      AppLocalizations.of(context)!.theaddress,

      AppLocalizations.of(context)!.message,
      AppLocalizations.of(context)!.productreviews,
      AppLocalizations.of(context)!.feedback,
      AppLocalizations.of(context)!.language,
      AppLocalizations.of(context)!.signout,
    ];

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 32.h,
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
              MyCache.getString(key: CacheKeys.fullName).toString(),
              style: GoogleFonts.cairo(fontSize: 18.sp, height: 2.h),
            ),
            Text(
              MyCache.getString(key: CacheKeys.email).toString(),
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
                        Navigator.pushNamed(
                            context, RouteName.getImageFromUser);
                      } else if (index == 2) {
                        Navigator.pushNamed(
                            context, RouteName.getAllAdress);
                      } else if (index == 3) {
                        Navigator.pushNamed(
                            context, RouteName.getMessage);
                      }  else if (index == 4) {
                        Navigator.pushNamed(
                            context, RouteName.getMyReviewsRoute);
                      } else if (index == 5) {
                        Navigator.pushNamed(
                            context, RouteName.getFeedback);
                      } else if (index == 6) {
                        showLanguageBottomSheet();
                      } else if (index == 7) {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) => CustomBackForAppBar(
                            text: AppLocalizations.of(context)!
                                .doyouwanttologout,
                            onPressed: () {
                              MyCache.removeFromShared(
                                  key: CacheKeys.token);
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
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                    child: Divider(
                      thickness: 1.sp,
                    ),
                  );
                },
                itemCount: text.length),
          ],
        ),
      ),
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


// }
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
