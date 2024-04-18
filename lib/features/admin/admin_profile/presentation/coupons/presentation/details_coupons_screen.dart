import 'package:flutter/material.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widget/custom_details_coupons.dart';

class DetailsCouponsScreen extends StatelessWidget {
  const DetailsCouponsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.coupons,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          children: [
            CustomDetailsCoupons(name: "Happy Coupon", expire: "17/8/2023", discount: "50%")
          ],
        ),
      ),
    );
  }
}
