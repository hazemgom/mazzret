import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/reviews/presentation/custom_review.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetReviewScreen extends StatelessWidget {
   GetReviewScreen({Key? key}) : super(key: key);
  List<String> image = [
    AppAssets.product1,
    AppAssets.product2,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.review,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
        child: Column(
          children: [
            Expanded(child: ListView.builder(
              itemCount: image.length,
                itemBuilder: (context,index){
                  return CustomReview(
                    image: image[index],
                    nameOfProducr: AppLocalizations.of(context)!.helloketchup,
                    rating: 2,
                  );
                }))
          ],
        ),
      ),
    );
  }
}
