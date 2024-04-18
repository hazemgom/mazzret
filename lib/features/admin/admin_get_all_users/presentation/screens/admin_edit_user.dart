import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/managers/get_all_users_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/managers/profile_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/custom_container_my_account.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_phone_widget.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

import '../../../../../utils/custom_widgets/custom_phone_text_field.dart';

class AdminEditUser extends StatefulWidget {
  Map<String, dynamic> map;

  AdminEditUser({
    Key? key,
    required this.map,
  }) : super(key: key);

  @override
  State<AdminEditUser> createState() => _AdminEditUserState();
}

class _AdminEditUserState extends State<AdminEditUser> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final TextEditingController latController = TextEditingController();

  final TextEditingController lngController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController zipController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.editUserData,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
      ),
      body: BlocProvider(
        create: (context) => GetAllUsersCubit()
          ..getSpecificUserOrAdminOrManagerFunction(id: widget.map['userId']),
        child: BlocConsumer<GetAllUsersCubit, GetAllUsersState>(
          listener: (context, state) {
            if (state is UpdateSpecificUserSuccessState) {
              // GetAllUsersCubit.get(context)
              //     .getSpecificUserOrAdminOrManagerFunction(
              //         id: widget.map['userId']);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, RouteName.detailsUser,
                  arguments: widget.map['userId']);
            } else if (state is UpdateSpecificUserErrorState) {
              CustomSnackBar.showMessage(
                context,
                message: 'يجب عليك تغيير الموقع',
                messageColor: Colors.red,
              );
            }
          },
          builder: (context, state) {
            var specificUserCubit = GetAllUsersCubit.get(context);

            return specificUserCubit.specificUserModel == null
                ? const Center(
                    child: CustomLoading(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  CustomTextFormFiled(
                                    label: widget.map['lat'] == null
                                        ? specificUserCubit
                                            .specificUserModel!.data!.lat
                                            .toString()
                                        : widget.map['lat'].toString(),
                                    readOnly: true,
                                    controller: latController,
                                    validator: (text) {
                                      // if (text!.isEmpty || text == null) {
                                      //   return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.lat}";
                                      // }
                                    },
                                  ),
                                  CustomTextFormFiled(
                                    label: widget.map['lng'] == null
                                        ? specificUserCubit
                                            .specificUserModel!.data!.lng
                                            .toString()
                                        : widget.map['lng'].toString(),
                                    readOnly: true,
                                    controller: lngController,
                                    validator: (text) {
                                      // if (text!.isEmpty || text == null) {
                                      //   return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.lat}";
                                      // }
                                    },
                                  ),
                                  CustomTextFormFiled(
                                    label: widget.map['address'] ??
                                        specificUserCubit
                                            .specificUserModel!.data!.address
                                            .toString(),
                                    readOnly: true,
                                    controller: addressController,
                                    validator: (text) {
                                      // if (text!.isEmpty || text == null) {
                                      //   return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.lat}";
                                      // }
                                    },
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        Map<String, dynamic> map = {
                                          'userId': widget.map['userId'],
                                          'lat': widget.map['lat'] ??
                                              specificUserCubit
                                                  .specificUserModel!.data!.lat,
                                          'lng': widget.map['lng'] ??
                                              specificUserCubit
                                                  .specificUserModel!.data!.lng,
                                          'address': widget.map['address'] ??
                                              specificUserCubit
                                                  .specificUserModel!
                                                  .data!
                                                  .address,
                                        };
                                        print('p');
                                        Navigator.pushNamed(
                                            context,
                                            RouteName
                                                .mapToSearchRouteInEditUser,
                                            arguments: map);
                                      },
                                      overlayColor: MaterialStateProperty.all(
                                        AppColors.primaryColor.withOpacity(0.2),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.h),
                                        child: SvgPicture.asset(
                                          AppAssets.locationIcon,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTextFormFiled(
                                    label: specificUserCubit
                                        .specificUserModel!.data!.name!,
                                    controller: nameController,
                                    validator: (text) {
                                      if (text!.isEmpty || text == null) {
                                        return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.name}";
                                      }
                                    },
                                  ),
                                  CustomTextFormFiled(
                                    label: specificUserCubit
                                        .specificUserModel!.data!.email!,
                                    controller: emailController,
                                    validator: (text) {
                                      if (text!.isEmpty || text == null) {
                                        return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.email}";
                                      }
                                    },
                                  ),
                                  // CustomPhoneTextField(
                                  //   text: specificUserCubit
                                  //       .specificUserModel!.data!.phone!,
                                  //   controller: phoneNumberController,
                                  //   validator: (text) {
                                  //     // if (text!.isEmpty || text == null) {
                                  //     //   return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.phonenumber}";
                                  //     // }
                                  //   },
                                  // ),
                                  CustomFormField(
                                    codeControlere: codeController,
                                    hintText: AppLocalizations.of(context)!
                                        .phonenumber,
                                    obsecureText: false,
                                    textInputType: TextInputType.phone,
                                    controller: phoneNumberController,
                                    validator: (text) {
                                      if (text!.isEmpty) {
                                        return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.phonenumber}";
                                      }
                                    },
                                  ),
                                  specificUserCubit.specificUserModel!.data!
                                              .enablePermission ==
                                          false
                                      ? Container()
                                      : Container(
                                          margin: EdgeInsets.only(
                                              top: 10.h,
                                              left: 10.w,
                                              right: 10.w),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.w,
                                                color: AppColors.grey
                                                    .withOpacity(0.7)),
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                          ),
                                          child: CheckboxListTile(
                                            overlayColor:
                                                MaterialStateProperty.all(
                                              AppColors.primaryColor,
                                            ),
                                            activeColor: AppColors.primaryColor,
                                            title: Text(
                                              AppLocalizations.of(context)!
                                                  .makeaccesstoaddproduct,
                                              style: GoogleFonts.cairo(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: isChecked
                                                    ? AppColors.primaryColor
                                                    : Colors.black38,
                                              ),
                                            ),
                                            value: isChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isChecked = value ?? false;
                                              });
                                            },
                                          ),
                                        ),
                                  SizedBox(height: 20.h),
                                  state is UpdateSpecificUserLoadingState
                                      ? const Center(
                                          child: CustomLoading(),
                                        )
                                      : CustomButtonWidget(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              if (widget.map['lat'] == null ||
                                                  widget.map['lng'] == null ||
                                                  widget.map['address'] ==
                                                      null) {
                                                CustomSnackBar.showMessage(
                                                  context,
                                                  message:
                                                      'يجب عليك تغيير الموقع',
                                                  messageColor: Colors.red,
                                                );
                                              } else {
                                                specificUserCubit
                                                    .updateSpecificUserOrAdminOrManagerFunction(
                                                  id: widget.map['userId'],
                                                  name: nameController.text,
                                                  email: emailController.text,
                                                  phone: codeController.text +
                                                      phoneNumberController
                                                          .text,
                                                  lat: widget.map['lat']
                                                      .toString(),
                                                  lng: widget.map['lng']
                                                      .toString(),
                                                  address:
                                                      widget.map['address'],
                                                  // enablePermission:
                                                  //     specificUserCubit
                                                  //                 .specificUserModel!
                                                  //                 .data!
                                                  //                 .role ==
                                                  //             'admin'
                                                  //         ? false
                                                  //         : isChecked,
                                                );
                                              }
                                            }
                                          },
                                          text: 'تأكيد',
                                          borderRadius: 10.r,
                                          width: 335.w,
                                          height: 49.h,
                                        ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
