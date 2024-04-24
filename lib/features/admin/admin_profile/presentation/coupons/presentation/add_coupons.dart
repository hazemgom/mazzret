import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class AddCoupons extends StatelessWidget {
   AddCoupons({Key? key}) : super(key: key);
 TextEditingController nameController=TextEditingController();
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
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
          child: Column(
            children: [
              CustomTextFormFiled(label: AppLocalizations.of(context)!.name, controller: nameController),
              CustomTextFormFiled(label: AppLocalizations.of(context)!.expiration, controller: nameController),
              CustomTextFormFiled(label: AppLocalizations.of(context)!.discount, controller: nameController),
              SizedBox(height: 20.h,),
              CustomButtonWidget(
                height: 48.h,
                width: 227.w,
                text: AppLocalizations.of(context)!.submit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
