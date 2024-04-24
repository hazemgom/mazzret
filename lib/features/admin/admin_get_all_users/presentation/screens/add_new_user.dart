import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/managers/get_all_users_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/presentation/screens/get_all_user.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/login_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/home_layout_screen.dart';
import 'package:mozart_flutter_app/provider/provider.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_divider.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_phone_text_field.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_phone_widget.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/navigation.dart';
import 'package:mozart_flutter_app/utils/location_helper.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewUser extends StatefulWidget {
  String? address, lat, lng;
  String? type;

  AddNewUser({Key? key, this.address, this.lng, this.lat, this.type})
      : super(key: key);

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  String? gender;

  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  bool isChecked = true;

  @override
  void initState() {
    print('-------------');
    print(widget.type);
    print('-------------');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.addnewuser,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<GetAllUsersCubit, GetAllUsersState>(
        listener: (context, state) {
          var cubit = GetAllUsersCubit.get(context);
          if (state is AddNewManagerOrAdminSuccessState) {
            Navigator.pop(context);
            return CustomSnackBar.showMessage(
              context,
              message: 'تمت عملية الأضافة بنجاح',
              messageColor: AppColors.primaryColor,
            );
          } else if (state is AddNewManagerOrAdminErrorState) {
            return CustomSnackBar.showMessage(
              context,
              message: 'حدثت مشكلة أثناء أضافة مستخدم جديد',
              messageColor: Colors.red,
            );
          }
        },
        builder: (context, state) {
          var addNewUser = GetAllUsersCubit.get(context);

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(right: 25.w, left: 25.w, top: 20.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .enteryouraccountdetailsbelow,
                        style: AppFonts.bodyText,
                      ),
                    ],
                  ),
                  Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextFormFiled(
                            validator: (text) {},
                            label: widget.address != null ||
                                    widget.lat != null ||
                                    widget.lng != null
                                ? '${widget.address}, ${widget.lat}, ${widget.lng}'
                                : AppLocalizations.of(context)!
                                    .clickthebuttonbelowtobringthecurrentlocationtoyou,
                            controller: locationController,
                            readOnly: true,
                            hintText: AppLocalizations.of(context)!
                                .clickthebuttonbelowtobringthecurrentlocationtoyou,
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(12.sp),
                              child: SvgPicture.asset(
                                AppAssets.locationIcon,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          CustomButtonWidget(
                            onPressed: () async {
                              Navigator.pushReplacementNamed(
                                context,
                                RouteName.mapToSearchRoute,
                              );
                            },
                            color: AppColors.primaryColor,
                            borderRadius: 10.r,
                            width: 335.w,
                            height: 49.h,
                            text: AppLocalizations.of(context)!.pressHere,
                          ),
                          CustomTextFormFiled(
                            label: AppLocalizations.of(context)!.name,
                            controller: nameController,
                            validator: (text) {
                              if (text!.isEmpty || text == null) {
                                return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.name}";
                              }
                            },
                          ),
                          CustomTextFormFiled(
                            label: AppLocalizations.of(context)!.email,
                            controller: emailController,
                            validator: (text) {
                              if (text!.isEmpty || text == null) {
                                return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.email}";
                              } else if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[com]")
                                  .hasMatch(text)) {
                                return AppLocalizations.of(context)!
                                    .pleaseentervalid;
                              }
                            },
                          ),
                          CustomTextFormFiled(
                            label: AppLocalizations.of(context)!.password,
                            controller: passwordController,
                            validator: (text) {
                              if (text!.isEmpty || text == null) {
                                return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.password}";
                              }
                            },
                          ),
                          CustomTextFormFiled(
                            label:
                                AppLocalizations.of(context)!.confirmpassword,
                            controller: confirmPasswordController,
                            validator: (text) {
                              if (text!.isEmpty || text == null) {
                                return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.confirmpassword}";
                              }
                            },
                          ),
                          // CustomPhoneTextField(
                          //   text: AppLocalizations.of(context)!.phonenumber,
                          //   controller: phoneNumberController,
                          //   validator: (text) {
                          //     // if (text!.isEmpty || text == null) {
                          //     // return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.phonenumber}";
                          //     // }
                          //   },
                          // ),
                          CustomFormField(
                            codeControlere: codeController,
                            hintText: AppLocalizations.of(context)!.phonenumber,
                            obsecureText: false,
                            textInputType: TextInputType.phone,
                            controller: phoneNumberController,
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.phonenumber}";
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.type == 'admin'
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(
                              top: 10.h, left: 10.w, right: 10.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.w,
                                color: AppColors.grey.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: CheckboxListTile(
                            overlayColor: MaterialStateProperty.all(
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
                  RadioListTile(
                    activeColor: AppColors.primaryColor,
                    title: Text(AppLocalizations.of(context)!.admin),
                    value: "admin",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    activeColor: AppColors.primaryColor,
                    title: Text(AppLocalizations.of(context)!.manager),
                    value: "manager",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  state is AddNewManagerOrAdminLoadingState
                      ? const Center(
                          child: CustomLoading(),
                        )
                      : CustomButtonWidget(
                          onPressed: () {
                            print(isChecked);
                            if (formKey.currentState!.validate()) {
                              addNewUser.addNewManagerOrAdminFunction(
                                name: nameController.text,
                                email: emailController.text,
                                phone: codeController.text +
                                    phoneNumberController.text,
                                password: passwordController.text,
                                passwordConfirm: confirmPasswordController.text,
                                role: gender!,
                                lat: widget.lat!,
                                lng: widget.lng!,
                                address: widget.address!,
                                // enablePermission: isChecked ? isChecked : false,
                              );
                            }
                          },
                          borderRadius: 10.r,
                          text: AppLocalizations.of(context)!.createanaccount,
                          width: 335.w,
                          height: 49.h,
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
