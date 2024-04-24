import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CustomEmpty extends StatelessWidget {
  CustomEmpty({
    Key? key,
    required this.image,
    required this.text,
    required this.textButton,
    required this.onTap,
  }) : super(key: key);
  String image;
  String text;
  String textButton;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(image),
          SizedBox(height: 20.h),
          Text(
            text,
            style: AppFonts.primarytext,
          ),
          SizedBox(height: 18.h),
          InkWell(
            onTap: onTap,
            child: CustomButtonWidget(
              text: textButton,
              height: 46.h,
              width: 227.w,
            ),
          )
        ],
      ),
    );
  }
}
