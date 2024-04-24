import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/presentation/screens/category/details_category.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class AdminCategoryScreen extends StatelessWidget {
  const AdminCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> image = [
      AppAssets.category1,
      AppAssets.category2,
      AppAssets.category3,
      AppAssets.category4,
      AppAssets.category5,
      AppAssets.category6,
      AppAssets.category7,
      AppAssets.category8,
      AppAssets.category1,
      AppAssets.category2,
      AppAssets.category3,
      AppAssets.category4,
      AppAssets.category5,
      AppAssets.category6,
      AppAssets.category7,
      AppAssets.category8,
      AppAssets.category8,
      AppAssets.category8,
    ];
    List<String> text = [
      AppLocalizations.of(context)!.waters,
      AppLocalizations.of(context)!.meatandchicken,
      AppLocalizations.of(context)!.icecreame,
      AppLocalizations.of(context)!.bakedgoods,
      AppLocalizations.of(context)!.fruitsandvegetables,
      AppLocalizations.of(context)!.colddrinks,
      AppLocalizations.of(context)!.waters,
      AppLocalizations.of(context)!.thebreakfast,
      AppLocalizations.of(context)!.dairyandmilk,
      AppLocalizations.of(context)!.waters,
      AppLocalizations.of(context)!.meatandchicken,
      AppLocalizations.of(context)!.icecreame,
      AppLocalizations.of(context)!.bakedgoods,
      AppLocalizations.of(context)!.fruitsandvegetables,
      AppLocalizations.of(context)!.colddrinks,
      AppLocalizations.of(context)!.waters,
      AppLocalizations.of(context)!.thebreakfast,
      AppLocalizations.of(context)!.dairyandmilk,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.category,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteName.adminAddNewCategory);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Center(
        child: GridView.builder(
          itemCount: image.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          primary: false,
          padding: EdgeInsets.all(10.sp),
          itemBuilder: (context, index) {
            return CustomCategory(
              image: image[index],
              text: text[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminDetailsCategory(
                      image: image[index],
                      text: text[index],
                      name: '',
                      namear: '',
                      createdAt: '',
                      updatedAt: '',
                      categoryId: '',
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
