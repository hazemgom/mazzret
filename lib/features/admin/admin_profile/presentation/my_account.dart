import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/edit_profile_screen.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/presentation/widget/custom_container_my_account.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class AdminMyAccount extends StatelessWidget {
  const AdminMyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> title=[
      AppLocalizations.of(context)!.name,
      AppLocalizations.of(context)!.email,
      AppLocalizations.of(context)!.password,
      AppLocalizations.of(context)!.phonenumber,
      AppLocalizations.of(context)!.streetname,
      AppLocalizations.of(context)!.apartment,
      AppLocalizations.of(context)!.zipcountry,
      AppLocalizations.of(context)!.city,
      AppLocalizations.of(context)!.country,

    ];
    List<String> name=[
      "Amira Adel",
      "amira@gmail.com",
      "01061489546",
      "*******",
      "streetname",
      "apartment",
      "zipcountry",
      "city",
      "country",

    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.myaccount
          ,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) => EditProfileScreen(
                  name: name[0],
                  email: name[1],
                  phone: name[2],
                  lat: '',
                  address: '',
                  lng: '',
                ),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen(
            //     name: name[0], email: name[1], phone: name[2], password: name[3], city: name[4], country: name[5], apartment: name[6], streetname: name[7], zipcode: name[8],),),);

          }, icon: Icon(Icons.edit_outlined))
        ],
      ),
      body: ListView.builder(
        itemCount: title.length,
          itemBuilder: (context,index ){
            return CustomContainerMyAccount(titleText: title[index], name: name[index]);
          }

      )
    );

  }
}
