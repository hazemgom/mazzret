import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
String? phoneNum;

class CustomPhoneTextField extends StatelessWidget {
  CustomPhoneTextField(
      {Key? key,
      required this.text,
      required this.controller,
        this.onPhoneNumberChanged,
        this.onSubmitPressed,
      required this.validator})
      : super(key: key);
  String text;

  final String? Function(dynamic text) validator;
  TextEditingController controller = TextEditingController();
  final Function(String, String)? onPhoneNumberChanged;
  final Function()? onSubmitPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: AppColors.grey)),
        child: Stack(
          children: [
            InternationalPhoneNumberInput(
              onInputChanged: (value) {
                print(value.phoneNumber);
                phoneNum = value.phoneNumber;
                onPhoneNumberChanged!(value.phoneNumber!, value.dialCode!);
                // controller.text = value.phoneNumber!;
              },

              validator: validator,
              cursorColor: Colors.black,
              textFieldController: controller,
              keyboardType: TextInputType.number,
              textStyle: GoogleFonts.cairo(
                height: 1.4.h,
                fontSize: 18.sp,
              ),
              inputDecoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 15.h, left: 0),
                border: InputBorder.none,
                hintText: text,
                hintStyle: AppFonts.bodyText.copyWith(
                  height: 1.4.h,
                  color: Colors.black38,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
