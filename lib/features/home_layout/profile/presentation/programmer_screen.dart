import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/custom_container_my_account.dart';
import 'package:mozart_flutter_app/utils/constants/constants.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget/custom_container_in_connect_with_us.dart';

class ProgrammerScreen extends StatelessWidget {
  const ProgrammerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> image = [
      AppAssets.callIcon,
      AppAssets.facebookIcon,
      AppAssets.whatsappIcon,
    ];
    List<String> text = [
      AppLocalizations.of(context)!.call,
      AppLocalizations.of(context)!.facebook,
      AppLocalizations.of(context)!.whatsaap,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.programmer,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.programmerDetails,
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomContainerMyAccount(
              titleText: AppLocalizations.of(context)!.name,
              name: AppLocalizations.of(context)!.omarAbdelAziz,
            ),
            CustomContainerMyAccount(
              titleText: AppLocalizations.of(context)!.email,
              name: AppLocalizations.of(context)!.emailOmar,
            ),
            CustomContainerMyAccount(
              titleText: AppLocalizations.of(context)!.phonenumber,
              name: AppLocalizations.of(context)!.omarPhone,
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const Divider(color: Colors.black87),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.socialmedia,
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: image.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          launch('tel:+201027324902');
                        } else if (index == 1) {
                          AppConstants.launchFacebookProfile(
                              faceLink:
                                  'https://www.facebook.com/omar.belal.52493499/');
                        } else if (index == 2) {
                          AppConstants.openWhatsAppChat(
                              num: '+201027324902',
                              urlLink: 'https://wa.me/+201027324902');
                        }
                      },
                      child: CustomContainerConnectWithUs(
                        image: image[index],
                        text: text[index],
                      ));
                }),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: const Divider(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
