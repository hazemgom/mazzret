import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddAdressOfBranch extends StatelessWidget {
   AddAdressOfBranch({Key? key}) : super(key: key);

 TextEditingController zipcontroller=TextEditingController();
 TextEditingController countrycontroller=TextEditingController();
 TextEditingController citycontroller=TextEditingController();
 TextEditingController streetmentcontroller=TextEditingController();
 TextEditingController apartmentcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.addnewadress,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
          child: Column(
            children: [
              CustomTextFormFiled(label: AppLocalizations.of(context)!.zipcountry,controller: zipcontroller),
              CustomTextFormFiled(label: AppLocalizations.of(context)!.country,controller: zipcontroller),
              CustomTextFormFiled(label: AppLocalizations.of(context)!.city,controller: zipcontroller),
              CustomTextFormFiled(label: AppLocalizations.of(context)!.streetname,controller: zipcontroller),
              CustomTextFormFiled(label: AppLocalizations.of(context)!.apartment,controller: zipcontroller),
                  SizedBox(height: 20.h,),
              CustomButtonWidget(
                text:  AppLocalizations.of(context)!.addnewadress,
                height: 48.h,
                width: 227.w,

              )
            ],
          ),
        ),
      ),
    );
  }
}
