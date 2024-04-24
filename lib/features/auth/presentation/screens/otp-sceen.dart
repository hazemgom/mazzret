import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../managers/auth_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'login_screen.dart';
class OtpScreen extends StatelessWidget {
  OtpScreen({required this.email,required this.phoneNumber});
  TextEditingController pinEditingController = TextEditingController(text: '');

  String? email;
  String? phoneNumber;
  int ?otpInt;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is VerifyOTPSuccessState) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(
                message: 'verify success',
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false,
            );
          }
          if (state is VerifyOTPErrorState) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: 'Enter correct Otp OR Check Your Number if it correct',
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,

              title: Text(
                AppLocalizations.of(context)!.verify,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Check Sms in Number:${phoneNumber}',
                        style: GoogleFonts.tajawal(fontSize: 20, fontWeight: FontWeight.w700),),
                    ],
                  ),
                  const SizedBox(height: 250,),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child:PinCodeTextField(
                      appContext: context,
                      length: 4,
                      controller: pinEditingController,
                      onCompleted: (value) {
                        int? otpInt = int.tryParse(value);
                        if (otpInt != null) {
                          print('Entered OTP: $otpInt');
                          cubit.putData(email: email!, otp: otpInt);
                        } else {
                          print('nullllllllllllllllllllllllll');
                        }
                      },
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 50,
                        fieldWidth: 60, // Adjust width here
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white, // Set color if no number is entered
                      ),
                      cursorColor: Colors.green,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onSubmitted: (value) {
                        print('Entered OTP: $value');
                        otpInt = int.tryParse(value);
                      },
                    ),

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

