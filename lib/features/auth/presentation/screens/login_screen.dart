import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/managers/auth_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_back_for_app.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscure = true;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            AppLocalizations.of(context)!.signin,
            style: AppFonts.titleScreen.copyWith(height: 0),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              print(BlocProvider.of<AuthCubit>(context).userModel.data!.role);
              if (BlocProvider.of<AuthCubit>(context).userModel.data!.role == 'user-normal' ||
                  BlocProvider.of<AuthCubit>(context).userModel.data!.role == 'user-wholesale') {
                Navigator.pushReplacementNamed(
                    context, RouteName.homeLayoutRoute);
                CustomSnackBar.showMessage(
                  context,
                  message: AppLocalizations.of(context)!.loginSuccessfully,
                  messageColor: AppColors.primaryColor,
                );
              } else if (BlocProvider.of<AuthCubit>(context)
                          .userModel
                          .data!
                          .role ==
                      'manager' ||
                  BlocProvider.of<AuthCubit>(context).userModel.data!.role ==
                      'admin') {
                Navigator.pushReplacementNamed(
                    context, RouteName.adminHomeLayoutRoute);
                CustomSnackBar.showMessage(
                  context,
                  message: AppLocalizations.of(context)!.loginSuccessfully,
                  messageColor: AppColors.primaryColor,
                );
              }
            } else if (state is LoginErrorState) {
              CustomSnackBar.showMessage(
                context,
                message: AppLocalizations.of(context)!
                    .aproblemwasencounteredwhileloggingin,
                messageColor: Colors.red,
              );
            }
          },
          builder: (context, state) {
            var loginCubit = AuthCubit.get(context);

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(right: 25.w, left: 25.w, top: 40.h),
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextFormFiled(
                            hintText: AppLocalizations.of(context)!.note,
                            label:
                                '${AppLocalizations.of(context)!.email} ${AppLocalizations.of(context)!.or} ${AppLocalizations.of(context)!.phonenumber}',
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.email} ${AppLocalizations.of(context)!.or} ${AppLocalizations.of(context)!.phonenumber}";
                              } else if (loginCubit.checkEmail(text) == true
                                  ? !RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[com]")
                                      .hasMatch(text)
                                  : text.isEmpty) {
                                return loginCubit.checkEmail(text) == true
                                    ? AppLocalizations.of(context)!
                                        .pleaseentervalid
                                    : '${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.phonenumber}';
                              }
                            },
                          ),
                          CustomTextFormFiled(
                            label: AppLocalizations.of(context)!.password,
                            controller: passwordController,
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
                                      )),
                            obscureText: obscure,
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.password}";
                              }
                            },
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RouteName.checkPhoneOrEmailRoute,
                                        arguments: emailController.text);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .forgetpassword,
                                    style: AppFonts.primarytext.copyWith(
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    state is LoginLoadingState
                        ? const CustomLoading()
                        : CustomButtonWidget(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await loginCubit.loginFunction(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            borderRadius: 10.r,
                            text: AppLocalizations.of(context)!.signin,
                            width: 335.w,
                            height: 49.h,
                          ),
                    SizedBox(height: 12.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.registerRoute);
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                AppLocalizations.of(context)!.donthaveanaccount,
                            style: AppFonts.primarytext,
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.createanaccount,
                            style: AppFonts.primarytext.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),
                    ),
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
