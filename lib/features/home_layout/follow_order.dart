import 'package:flutter/material.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_empty.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class FollowOrder extends StatelessWidget {
  const FollowOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.followorder,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: CustomEmpty(
        image: AppAssets.orderIcon,
        text: AppLocalizations.of(context)!.norequestadded,
        onTap: () {
          Navigator.pushReplacementNamed(context, RouteName.homeLayoutRoute);
        },
        textButton: AppLocalizations.of(context)!.startbrowsing,
      ),
    );
  }
}
