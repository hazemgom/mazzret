import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cach_keys.dart';
import 'package:mozart_flutter_app/features/auth/data/data_provider/local/cache.dart';
import 'package:mozart_flutter_app/features/auth/managers/auth_cubit.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/otp-sceen.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_back_for_app.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_divider.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_phone_text_field.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_phone_widget.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/location_helper.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../test.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscure = true;
  static SharedPreferences? preferences;

  String phoneNumber = '';
  String countryCode = '';

  Country? country;
  String flag = AppAssets.lb;

  @override
  void initState() {
    init().then((value) {
      print(
          '*************  ${preferences!.getString('myLocation')}  **************');
      print(
          '*************  ${preferences!.getString('myLocation')}  **************');
    });
    if (preferences != null) {
      if (preferences!.getString('myLocation') !=
          null) {
        setState(() {
          if(mounted){
            AuthCubit.get(context).getPlaceAndPosition();

          }
          locationController.text = preferences!.getString('myLocation')!;

          preferences!.getString('myLocation');
          print(preferences!
              .getString('myLocation'));
        });
      }
    }
    super.initState();
  }

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final TextEditingController zipCodeController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

  final TextEditingController streetNameController = TextEditingController();

  final TextEditingController apartmentController = TextEditingController();

  final TextEditingController floorNumberController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  String? selectItem;
  String? newf;

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      AppLocalizations.of(context)!.retailclient,
      AppLocalizations.of(context)!.wholesalecustomer
    ];

    return WillPopScope(
      onWillPop: () async {
        showAdaptiveDialog(
          context: context,
          builder: (context) => CustomBackForAppBar(
            text: AppLocalizations.of(context)!.doyouwanttoexit,
            onPressed: () {
              SystemNavigator.pop();
            },
            text2: AppLocalizations.of(context)!.exit,
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context)!.createanaccount,
            style: AppFonts.titleScreen.copyWith(height: 0),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SignupSuccessState) {
              MyCache.removeFromShared(key: CacheKeys.myLocation);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return OtpScreen(
                    email: emailController.text,
                    phoneNumber:
                        codeController.text + phoneNumberController.text);
              }));
              CustomSnackBar.showMessage(
                context,
                message: AppLocalizations.of(context)!.signupSuccess,
                messageColor: AppColors.primaryColor,
              );
            } else if (state is SignupErrorState) {
              CustomSnackBar.showMessage(context,
                  message: AppLocalizations.of(context)!
                      .aproblemwasfoundwhilecreatinganaccount,
                  messageColor: Colors.red);
            }
          },
          builder: (context, state) {
            var registerCubit = AuthCubit.get(context);

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
                              label: AppLocalizations.of(context)!.name,
                              keyboardType: TextInputType.name,
                              controller: nameController,
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.name}";
                                }
                              },
                            ),
                            CustomTextFormFiled(
                              label: AppLocalizations.of(context)!.email,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              validator: (text) {
                                if (text!.isEmpty) {
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
                              keyboardType: TextInputType.visiblePassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                                icon: obscure
                                    ? Icon(
                                        Icons.visibility_off,
                                        size: 24.sp,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        size: 24.sp,
                                      ),
                              ),
                              obscureText: obscure,
                              controller: passwordController,
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.password}";
                                }
                              },
                            ),
                            SizedBox(height: 20.h),
                            // CustomPhoneTextField(
                            //   text: AppLocalizations.of(context)!.phonenumber,
                            //   controller: phoneNumberController,
                            //   onPhoneNumberChanged: (number, code) {
                            //     phoneNumber = number;
                            //     countryCode = code;
                            //   },
                            //   onSubmitPressed: () {
                            //     // Handle the button press with the phone number and country code
                            //     print(
                            //         'Phone Number: $phoneNumber, Country Code: $countryCode');
                            //   },
                            //   validator: (text) {
                            //     //   if (text!.isEmpty || text == null) {
                            //     //     return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.phonenumber}";
                            //     //   }
                            //   },
                            // ),
                            /*********************************/
                            // CustomTextFormFiled(
                            //   label: country != null
                            //       ? "${country!.name.toString()} (+${country!.phoneCode})"
                            //       : AppLocalizations.of(context)!.phonenumber,
                            //   controller: phoneNumberController,
                            //   preffixIcon: InkWell(
                            //     child: country != null
                            //         ? Padding(
                            //             padding: const EdgeInsets.all(8.0),
                            //             child: Text(
                            //               country!.flagEmoji,
                            //               style: const TextStyle(
                            //                 fontSize: 23,
                            //               ),
                            //             ),
                            //           )
                            //         : Padding(
                            //             padding: EdgeInsets.all(8.0),
                            //             child: Text(
                            //               "🇱🇾 ${countryCode}",
                            //               style: TextStyle(
                            //                 fontSize: 23,
                            //               ),
                            //             ),
                            //           ),
                            //     onTap: () {
                            //       showCountryPicker(
                            //           context: context,
                            //           showPhoneCode: true,
                            //           exclude: ["IL"],
                            //           favorite: ["LB", "EG"],
                            //           onSelect: (Country c) {
                            //             setState(() {
                            //               country = c;
                            //               phoneNumberController.text =
                            //                   c.phoneCode;
                            //             });
                            //             print(c.flagEmoji.toString());
                            //             flag = c.flagEmoji;
                            //           }
                            //           // provider.changeCountry(country),
                            //           );
                            //     },
                            //   ),
                            //   keyboardType: TextInputType.phone,
                            // ),
                            /*********************************/
                            CustomFormField(
                              codeControlere: codeController,
                              hintText:
                                  AppLocalizations.of(context)!.phonenumbercode,
                              obsecureText: false,
                              textInputType: TextInputType.phone,
                              controller: phoneNumberController,
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.phonenumbercode}";
                                }
                              },
                            ),

                            CustomTextFormFiled(
                              validator: (text) {},
                              label: preferences == null && position == null
                                  ? AppLocalizations.of(context)!
                                      .clickthebuttonbelowtobringthecurrentlocationtoyou
                                  : preferences!
                                      .getString('myLocation')
                                      .toString(),
                              controller: locationController,
                              readOnly: true,
                              hintText: preferences == null && position == null
                                  ? AppLocalizations.of(context)!
                                      .clickthebuttonbelowtobringthecurrentlocationtoyou
                                  : preferences!
                                      .getString('myLocation')
                                      .toString(),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MapScreen();
                                    },
                                  ),
                                );

                              },
                              color: AppColors.primaryColor,
                              borderRadius: 10.r,
                              width: 335.w,
                              height: 49.h,
                              text: AppLocalizations.of(context)!.pressHere,
                            ),
                            SizedBox(height: 10.h),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              child: Directionality(
                                textDirection:
                                    MyCache.getString(key: CacheKeys.lang) ==
                                            'ar'
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: PopupMenuButton(
                                    elevation: 1.sp,
                                    child: ListTile(
                                      title: Text(
                                        selectItem ??
                                            AppLocalizations.of(context)!
                                                .choosetheclienttype,
                                        style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                          height: 1.h,
                                        ),
                                      ),
                                      trailing:
                                          const Icon(Icons.arrow_drop_down),
                                    ),
                                    itemBuilder: (BuildContext context) {
                                      return list.map((item) {
                                        return PopupMenuItem(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },
                                    onSelected: (newValue) {
                                      setState(() {
                                        selectItem = newValue;
                                        newf = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    state is SignupLoadingState
                        ? const CustomLoading()
                        : CustomButtonWidget(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (position != null && address != null) {
                                  print(address);
                                  if (newf == null || newf == '') {
                                    CustomSnackBar.showMessage(
                                      context,
                                      message: AppLocalizations.of(context)!
                                          .youmustchooseaclienttype,
                                      messageColor: Colors.red,
                                    );
                                  } else {
                                    await registerCubit.signUpFunction(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      passwordConfirm: passwordController.text,
                                      phone:
                                          '${codeController.text}${phoneNumberController.text}',
                                      lat: position!.latitude,
                                      lng: position!.longitude,
                                      address: address!,
                                      role: newf ==
                                              AppLocalizations.of(context)!
                                                  .retailclient
                                          ? 'user-normal'
                                          : newf ==
                                                  AppLocalizations.of(context)!
                                                      .wholesalecustomer
                                              ? 'user-wholesale'
                                              : '',
                                    );
                                    print(codeController.text +
                                        phoneNumberController.text);
                                    print('phonnne numbbbbbbbbbbbbbbbbbbbbber');
                                  }
                                } else {
                                  CustomSnackBar.showMessage(
                                    context,
                                    message: AppLocalizations.of(context)!
                                        .youmustchoosethecurrentlocation,
                                    messageColor: Colors.red,
                                  );
                                }
                              }
                            },
                            borderRadius: 10.r,
                            text: AppLocalizations.of(context)!.createanaccount,
                            width: 335.w,
                            height: 49.h,
                          ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDevider(
                            thicness: 0.3,
                            color: AppColors.grey,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.or,
                          style: AppFonts.bodyText,
                        ),
                        Expanded(
                          child: CustomDevider(
                            thicness: 0.3,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.loginRoute);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.signin,
                        style: AppFonts.primarytext.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    CustomDevider(
                      thicness: 0.3,
                      color: AppColors.grey,
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
