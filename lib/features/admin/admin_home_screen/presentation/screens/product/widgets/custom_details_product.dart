import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';

class CustomDetailsProduct extends StatefulWidget {
  CustomDetailsProduct(
      {Key? key,
      required this.image,
      required this.text,
      required this.text2,
       this.quantity=1,
      required this.text3})
      : super(key: key);
  String image;
  String text;
  String text2;
  String text3;
  int quantity;

  @override
  State<CustomDetailsProduct> createState() => _CustomDetailsProductState();
}

class _CustomDetailsProductState extends State<CustomDetailsProduct> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
            padding: EdgeInsets.symmetric( vertical: 36.h),
            child: Container(
                height: 235.h,
                width: 340.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(width: 0.2.w, color: AppColors.grey)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Image.asset(widget.image,)),
                      Text(
                        widget.text,
                        textAlign: TextAlign.start,
                        style:
                        TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 300.w,
                        child: Text(
                          widget.text2,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.normal,
                              color: AppColors.grey
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.quantity++;
                              });
                            },
                            child: Card(
                              elevation: 1,
                              child: Container(
                                height: 25.h,
                                width: 25.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(5.w),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "${widget.quantity}",
                            style: TextStyle(fontSize: 18.sp),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.quantity--;
                              });
                            },
                            child: Card(
                              elevation: 1,
                              child: Container(
                                height: 25.h,
                                width: 25.w,
                                decoration: BoxDecoration(
                                  color: AppColors.blue,
                                  borderRadius: BorderRadius.circular(5.w),
                                ),
                                child: Center(
                                  child: Icon(Icons.remove),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.text3,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),

                    ],
                  ),
                ))),
        Positioned(
            top: 50.h,
            left: 30.h,
            child: SvgPicture.asset(AppAssets.loveIcon,width: 30.w,height: 30.h,))
      ],
    );
  }
}
