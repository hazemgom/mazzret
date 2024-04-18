import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/managers/auth_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPasswordScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final String email;

  TextEditingController newpssController = TextEditingController();
  TextEditingController confirmpssController = TextEditingController();

  NewPasswordScreen({Key? key, required this.email}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.newpassword,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        leading: Container(),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is UpdatePasswordSuccessState) {
            Navigator.pushReplacementNamed(context, RouteName.loginRoute);
            CustomSnackBar.showMessage(
              context,
              message: AppLocalizations.of(context)!.updatePasswordSuccessfully,
              messageColor: AppColors.primaryColor,
            );
          } else if (state is UpdatePasswordErrorState) {
            CustomSnackBar.showMessage(
              context,
              message: AppLocalizations.of(context)!.aproblemwasencounteredwhilecreatinganewpassword,
              messageColor: Colors.red,
            );
          }
        },
        builder: (context, state) {
          var updateNewPassword = AuthCubit.get(context);

          return Padding(
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 50.h, bottom: 30.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Text(
                        AppLocalizations.of(context)!.enternewpassword,
                        style: AppFonts.black2Text,
                      ),
                    ),
                  ],
                ),
                Form(
                  key: formKey,
                    child: Column(
                  children: [
                    CustomTextFormFiled(
                      label: AppLocalizations.of(context)!.newpassword,
                      controller: newpssController,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.newpassword}";
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            AppLocalizations.of(context)!.confirmpassword,
                            style: AppFonts.black2Text,
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormFiled(
                      label: AppLocalizations.of(context)!.confirmpassword,
                      controller: confirmpssController,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.confirmpassword}";
                        }
                      },
                    ),
                  ],
                )),
                Spacer(),
                state is UpdatePasswordLoadingState
                    ? CustomLoading()
                    : CustomButtonWidget(
                        height: 48.h,
                        width: 300,
                        onPressed: () async {
                          print(email);
                          if (formKey.currentState!.validate()) {
                            await updateNewPassword.updatePasswordFunction(
                              email: email,
                              newPassword: newpssController.text,
                            );
                          }
                        },
                        text: AppLocalizations.of(context)!.confirm,
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
