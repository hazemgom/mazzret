
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDevider extends StatelessWidget {
   CustomDevider({Key? key ,required this.thicness,required this.color}) : super(key: key);
  double thicness;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 10.w,right: 10.r),
      child: Divider(
        thickness: thicness,
        color: color,
      ),
    );
  }
}
