import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/presentation/coupons/presentation/widget/custom_coupon.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CouponsScreen extends StatelessWidget {
  CouponsScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
 List<String> nameOfCoupons=[
   "Happy Coupons",
   "Happy Coupons",
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: (){
          Navigator.pushNamed(context, RouteName.addCoupons);

        },
        child: Icon(
            Icons.add
        ),
      ),

      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.coupons,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          children:[
           Row(
             children: [
               Text(AppLocalizations.of(context)!.allcoupons,
               style: AppFonts.black2Text,
               ),
             ],
           ),
            SizedBox(height: 20.h,),
            Expanded(
              child: ListView.builder(
                  itemCount: nameOfCoupons.length,
                  itemBuilder: (context,index){
                return CustomCoupons(name:nameOfCoupons[index]);
              }),
            )
          ],
        ),
      ),
    );
  }
}
