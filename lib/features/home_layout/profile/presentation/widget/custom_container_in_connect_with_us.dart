import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/provider/provider.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:provider/provider.dart';

class CustomContainerConnectWithUs extends StatelessWidget {
   CustomContainerConnectWithUs({Key? key,required this.image,required this.text} ) : super(key: key);
String image;
  String text;
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppProvider>(context);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 12.h),
      child: Container(
        padding: EdgeInsets.all(18.sp),
        height: 60.h,
        width: 335,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
            width: 0.2.w,
            color: AppColors.grey
          )
        ),
        child: Row(
          children: [
            SvgPicture.asset(image),
            SizedBox(width: 16.w,),
            Text(text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500
            ),
            ),
            Spacer(),
           provider.appLanguage=="en"?Icon(Icons.arrow_forward_ios,
           color: AppColors.grey,
               size: 15.sp,
           ):Icon(Icons.arrow_back_ios,
               color: AppColors.grey,
               size: 15.sp
           )


          ],
        ),
      ),
    );
  }
}
