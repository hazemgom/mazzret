import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/managers/profile_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_phone_text_field.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.lng,
    required this.lat,
    required this.address,
    // required this.city,
    // required this.country,
    // required this.apartment,
    // required this.streetname,
    // required this.zipcode,
  }) : super(key: key);
  String name, email, phone, address;
  dynamic lat, lng;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController streetNameController = TextEditingController();

  final TextEditingController apartmentController = TextEditingController();

  final TextEditingController floorNumberController = TextEditingController();

  final TextEditingController zipController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateUserDataSuccessState) {
          CustomSnackBar.showMessage(
            context,
            message: 'تمت عملية تحديث البيانات بنجاح',
            messageColor: AppColors.primaryColor,
          );
          BlocProvider.of<ProfileCubit>(context).getProfileData();
          Navigator.pop(context);
        } else if (state is UpdateUserDataErrorState) {
          CustomSnackBar.showMessage(
            context,
            message: 'تمت فشل عملية تحديث البيانات',
            messageColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        var updateUserDataCubit = ProfileCubit.get(context);

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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormFiled(
                    label: widget.name,
                    controller: nameController,
                    validator: (text) {
                      if (text!.isEmpty || text == null) {
                        return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.name}";
                      }
                    },
                  ),
                  CustomTextFormFiled(
                    label: widget.email,
                    controller: emailController,
                    validator: (text) {
                      if (text!.isEmpty || text == null) {
                        return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.email}";
                      }
                    },
                  ),
                  CustomPhoneTextField(
                    text: widget.phone,
                    controller: phoneNumberController,
                    validator: (text) {
                      if (text!.isEmpty || text == null) {
                        return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.phonenumber}";
                      }
                    },
                  ),
                  // CustomTextFormFiled(
                  //     label: password, controller: passwordController,
                  //   validator: (text) {
                  //     if (text!.isEmpty || text == null) {
                  //       return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.password}";
                  //     }
                  //   },
                  // ),
                  //--------
                  // CustomTextFormFiled(
                  //   label: widget.streetname,
                  //   controller: streetNameController,
                  //   validator: (text) {
                  //     if (text!.isEmpty || text == null) {
                  //       return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.streetname}";
                  //     }
                  //   },
                  // ),
                  // CustomTextFormFiled(
                  //   label: widget.apartment,
                  //   controller: apartmentController,
                  //   validator: (text) {
                  //     if (text!.isEmpty || text == null) {
                  //       return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.apartment}";
                  //     }
                  //   },
                  // ),
                  // CustomTextFormFiled(
                  //   label: widget.zipcode,
                  //   controller: zipController,
                  //   validator: (text) {
                  //     if (text!.isEmpty || text == null) {
                  //       return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.zipcountry}";
                  //     }
                  //   },
                  // ),
                  // CustomTextFormFiled(
                  //   label: widget.city,
                  //   controller: cityController,
                  //   validator: (text) {
                  //     if (text!.isEmpty || text == null) {
                  //       return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.city}";
                  //     }
                  //   },
                  // ),
                  // CustomTextFormFiled(
                  //   label: widget.country,
                  //   controller: countryController,
                  //   validator: (text) {
                  //     if (text!.isEmpty || text == null) {
                  //       return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.country}";
                  //     }
                  //   },
                  // ),
                  //--------
                  SizedBox(height: 20.h),
                  CustomButtonWidget(
                    onPressed: () {
                      updateUserDataCubit.updateUserData(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneNumberController.text,
                        street: streetNameController.text,
                        apartment: apartmentController.text,
                        zip: zipController.text,
                      );
                    },
                    text: 'تأكيد',
                    borderRadius: 10.r,
                    width: 335.w,
                    height: 49.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
