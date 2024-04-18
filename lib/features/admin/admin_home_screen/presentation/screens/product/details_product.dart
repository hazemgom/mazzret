import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/product/widgets/custom_details_product.dart';
import 'package:mozart_flutter_app/features/home_layout/home/presentation/product/widget/custom_details_product.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_field_connect_us.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailsProduct extends StatefulWidget {
  const DetailsProduct({Key? key}) : super(key: key);

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  @override
  double? _ratingValue;
  TextEditingController controller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.productdetails,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomDetailsProduct(
                    image: AppAssets.product1,
                    text: AppLocalizations.of(context)!.jokerspray,
                    text2: AppLocalizations.of(context)!
                        .dishpoolcarcleanerandpolishorangescent,
                    text3: " 3420دع"),
                SizedBox(
                  height: 20.h,
                ),
                CustomButtonWidget(
                  text: AppLocalizations.of(context)!.addtocart,
                  height: 48.h,
                  width: 247.w,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Divider(
                  thickness: 0.2.sp,
                  color: AppColors.grey,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.review,
                      style: AppFonts.blackText.copyWith(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    RatingBar(
                        itemSize: 30.sp,
                        initialRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.orange),
                            half: const Icon(
                              Icons.star_half,
                              color: Colors.orange,
                            ),
                            empty: const Icon(
                              Icons.star_outline,
                              color: Colors.orange,
                            )),
                        onRatingUpdate: (value) {
                          setState(() {
                            _ratingValue = value;
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormFieldConnectUs(
                  controller: controller,
                  maxLines: 3,
                  label: AppLocalizations.of(context)!.review,
                  validator: (String? value) {},
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomButtonWidget(
                  text: AppLocalizations.of(context)!.sendfeedback,
                  height: 48.h,
                  width: 247.w,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Divider(
                  thickness: 0.2.sp,
                  color: AppColors.grey,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.uploadimage,
                      style: AppFonts.blackText.copyWith(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                    height: 200,
                    width: 260,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                            width: 2.w, color: AppColors.primaryColor)),
                    child: Lottie.asset(AppAssets.uploadImage)),
                SizedBox(
                  height: 5.h,
                ),
                CustomButtonWidget(
                  text: AppLocalizations.of(context)!.sendimage,
                  height: 48.h,
                  width: 247.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
