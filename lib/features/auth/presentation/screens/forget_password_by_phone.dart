import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/managers/auth_cubit.dart';
import 'package:mozart_flutter_app/features/auth/managers/auth_cubit.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/login_screen.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_phone_widget.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class ForgetPasswordByPhoneScreen extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  ForgetPasswordByPhoneScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.forgetpassword,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccessState) {
            Navigator.pushReplacementNamed(
                context, RouteName.resetPasswordRoute,
                arguments: phoneController.text);
            CustomSnackBar.showMessage(
              context,
              message: AppLocalizations.of(context)!.successSendMail,
              messageColor: AppColors.primaryColor,
            );
          } else if (state is ForgetPasswordErrorState) {
            CustomSnackBar.showMessage(
              context,
              message: AppLocalizations.of(context)!.catchErrorinsendmail,
              messageColor: Colors.red,
            );
          }
        },
        builder: (context, state) {
          var forgetPasswordCubit = AuthCubit.get(context);

          return Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 50.h, bottom: 30.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.forgetpassword,
                        style: AppFonts.black2Text,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .enteryourphonewewillsend5digitsverificationcode,
                    style: AppFonts.greyText,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomFormField(
                    codeControlere: codeController,
                    hintText:
                    AppLocalizations.of(context)!.phonenumber,
                    obsecureText: false,
                    textInputType: TextInputType.phone,
                    controller: phoneController,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.phonenumber}";
                      }
                    },
                  ),
                  const Spacer(),
                  state is ForgetPasswordLoadingState
                      ? const CustomLoading()
                      : CustomButtonWidget(
                    height: 48.h,
                    width: 300.w,
                    text: AppLocalizations.of(context)!.sendcode,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await forgetPasswordCubit.forgetPasswordFunction(
                          emailOrPhone: codeController.text + phoneController.text,
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),

    );
  }
}
