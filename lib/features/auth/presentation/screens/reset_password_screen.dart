import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/managers/auth_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:pinput/pinput.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController pinputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: Container(),
        title: Text(
          AppLocalizations.of(context)!.verification,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is VerifyOTPSuccessState) {
            Navigator.pushReplacementNamed(
              context,
              RouteName.newPasswordRoute,
              arguments: widget.email,
            );
            CustomSnackBar.showMessage(
              context,
              message: AppLocalizations.of(context)!
                  .thecodeverificationprocesswascompletedsuccessfully,
              messageColor: AppColors.primaryColor,
            );
          } else if (state is VerifyOTPErrorState) {
            CustomSnackBar.showMessage(
              context,
              message: AppLocalizations.of(context)!
                  .thecodeverificationprocesswascompletednotsuccessfully,
              messageColor: Colors.red,
            );
          }
        },
        builder: (context, state) {
          var verifyOTPCubit = AuthCubit.get(context);

          return Padding(
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 50.h, bottom: 30.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.verification,
                      style: AppFonts.black2Text,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  AppLocalizations.of(context)!
                      .enteryouremailwewillsend5digitsverificationcode,
                  style: AppFonts.greyText,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: SizedBox(
                    width: 320.w,
                    height: 50.h,
                    child: Pinput(
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      controller: pinputController,
                      length: 6,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      focusedPinTheme: PinTheme(
                        height: 50.h,
                        width: 80.w,
                        // textStyle: AppFonts.textInPip,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          // color: AppColors.whiteColor,
                          border: Border.all(
                            width: 1.w,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      defaultPinTheme: PinTheme(
                        height: 50.h,
                        width: 80.w,
                        // textStyle: AppFonts.textInPip,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: AppColors.white,
                          border: Border.all(width: 1.w, color: AppColors.grey2),
                          // ),
                        ),
                      ),
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                      onCompleted: (value) async {
                        verifyOTPCubit.verifyOTPFunction(
                            resetCode: pinputController.text);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                // RichText(
                //   text:  TextSpan(children: [
                //     TextSpan(
                //         text: AppLocalizations.of(context)!.ifyoudidntreceiveacode,
                //         style: AppFonts.primarytext),
                //     SizedBox(width: 20.w),
                //     TextSpan(
                //         text: AppLocalizations.of(context)!.resend,
                //         style: AppFonts.primarytext.copyWith(fontWeight: FontWeight.bold)),
                //   ]),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.ifyoudidntreceiveacode,
                      style: AppFonts.primarytext,
                    ),
                  ],
                ),
                Spacer(),
                state is VerifyOTPLoadingState
                    ? const CustomLoading()
                    : CustomButtonWidget(
                        height: 48.h,
                        width: 300.w,
                        text: AppLocalizations.of(context)!.send,
                        onPressed: () {
                          verifyOTPCubit.verifyOTPFunction(
                              resetCode: pinputController.text);
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}


 class A {
  fun() {
   print('ppp');
  }
}

class B implements A {
  @override
  fun() {
    // TODO: implement fun
    throw UnimplementedError();
  }

}