import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/features/admin/admin_get_all_users/managers/get_all_users_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/get_image_from_user/managers/get_all_images_from_users_cubit.dart';
import 'package:mozart_flutter_app/features/admin/admin_profile/get_image_from_user/presentation/widget/custom_get_image_from_user.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class GetImageFromUser extends StatelessWidget {
  GetImageFromUser({Key? key}) : super(key: key);

  List<String> image = [
    AppAssets.product1,
    AppAssets.product2,
  ];

  String formattedDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat.yMMMMd().format(dateTime);
  }

  String formattedTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat.jm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllImagesFromUsersCubit, GetAllImagesFromUsersState>(
      builder: (context, state) {
        var getAllImagesFromUsersCubit =
            GetAllImagesFromUsersCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.suggestedpictures,
              style: AppFonts.titleScreen.copyWith(height: 0),
            ),
          ),
          body: getAllImagesFromUsersCubit.getAllImagesFromUserModel == null
              ? const Center(
                  child: CustomLoading(),
                )
              : getAllImagesFromUsersCubit
                      .getAllImagesFromUserModel!.data!.isEmpty
                  ? Center(
                      child: Text(
                        'No images uploads yet',
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w600,
                          fontSize: 22.sp,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 20.h),
                        child: Column(
                          children: [
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: getAllImagesFromUsersCubit
                                    .getAllImagesFromUserModel!.data!.length,
                                itemBuilder: (context, index) {
                                  var item = getAllImagesFromUsersCubit
                                      .getAllImagesFromUserModel!.data![index];

                                  return item.userdata == null
                                      ? Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                        child: Text(
                                            '${AppLocalizations.of(context)!.problemInUserData}$index',
                                            style: GoogleFonts.cairo(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                      )
                                      : CustomGetImageFromUser(
                                          image: item.image!.url!,
                                          nameOfuser: item.userdata!.name!,
                                          emailOfuser: item.userdata!.email!,
                                          phoneOfProduct: item.userdata!.phone!,
                                          nameOfProduct: item.nameOfProduct!,
                                          createdIn:
                                              formattedDate(item.createdAt!),
                                        );
                                })
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
