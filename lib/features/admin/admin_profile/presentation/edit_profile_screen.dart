import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_phone_text_field.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.city,
    required this.country,
    required this.apartment,
    required this.streetname,
    required this.zipcode,
  }) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();
  final TextEditingController floorNumberController = TextEditingController();

  String name,
      email,
      phone,
      password,
      city,
      country,
      apartment,
      zipcode,
      streetname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.editprofile,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextFormFiled(
                          label: name, controller: nameController,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.name}";
                          }
                        },
                      ),
                      CustomTextFormFiled(
                          label: email, controller: emailController,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.email}";
                          }
                        },
                      ),
                      CustomPhoneTextField(
                        text: phone,
                        controller: phoneNumberController,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.phonenumber}";
                          }
                        },
                      ),
                      CustomTextFormFiled(
                          label: password, controller: passwordController,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.password}";
                          }
                        },
                      ),
                      CustomTextFormFiled(
                          label: streetname, controller: streetNameController,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.streetname}";
                          }
                        },
                      ),
                      CustomTextFormFiled(
                          label: apartment, controller: apartmentController,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.apartment}";
                          }
                        },
                      ),
                      CustomTextFormFiled(
                          label: zipcode, controller: apartmentController,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.zipcountry}";
                          }
                        },
                      ),
                      CustomTextFormFiled(
                          label: city, controller: floorNumberController,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.city}";
                          }
                        },
                      ),
                      CustomTextFormFiled(
                          label: country, controller: floorNumberController,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.country}";
                          }
                        },
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
