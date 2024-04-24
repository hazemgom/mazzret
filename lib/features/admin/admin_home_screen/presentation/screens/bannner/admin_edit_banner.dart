import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/managers/admin_home_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/utils/constants/constants.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class AdminEditBanner extends StatefulWidget {
  String bannerId;

  AdminEditBanner({
    Key? key,
    required this.bannerId,
  }) : super(key: key);

  @override
  State<AdminEditBanner> createState() => _AdminEditBannerState();
}

class _AdminEditBannerState extends State<AdminEditBanner> {
  String? imagePath;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit()..getSpecificBanner(bannerId: widget.bannerId),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);

          return BlocConsumer<AdminHomeCubit, AdminHomeState>(
            listener: (context, state) {
              if (state is UpdateImageInBannerSuccessState) {
                Navigator.pushReplacementNamed(
                    context, RouteName.adminHomeLayoutRoute);
                BlocProvider.of<HomeCubit>(context).getBanners();
                return CustomSnackBar.showMessage(
                  context,
                  message: 'تمت عملية التعديل بنجاح',
                  messageColor: AppColors.primaryColor,
                );
              } else if (state is UpdateImageInBannerErrorState) {
                return CustomSnackBar.showMessage(
                  context,
                  message: 'حدثت مشكلة أثناء تعديل اللافتة',
                  messageColor: Colors.red,
                );
              }
            },
            builder: (context, state) {
              var adminHomeCubit = AdminHomeCubit.get(context);

              return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.primaryColor,
                  title: Text(
                    AppLocalizations.of(context)!.edit,
                    style: AppFonts.titleScreen.copyWith(height: 0),
                  ),
                  centerTitle: true,
                ),
                body: homeCubit.specificBannerModel == null
                    ? const Center(
                        child: CustomLoading(),
                      )
                    : SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 30.h),
                              GestureDetector(
                                onTap: _pickImage,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(8.r),
                                  padding: EdgeInsets.all(10.sp),
                                  color: AppColors.primaryColor,
                                  child: imagePath != null
                                      ? Image.file(
                                          File(imagePath!),
                                          height: 300.h,
                                          width: 200.w,
                                        )
                                      : CachedImage(
                                          link: homeCubit.specificBannerModel!
                                              .data!.images![0].url,
                                          width: 200.w,
                                          height: 300.h,
                                          borderRadius: 12.r,
                                        ),
                                ),
                              ),
                              SizedBox(height: 30.h),
                              Text(
                                'أضغط علي الصورة لتغيرها',
                                style: GoogleFonts.cairo(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                ),
                              ),
                              SizedBox(height: 30.h),
                              imagePath == null
                                  ? Container()
                                  : state is UpdateImageInBannerLoadingState
                                      ? const Center(
                                          child: CustomLoading(),
                                        )
                                      : CustomButtonWidget(
                                          onPressed: () async {
                                            if (imagePath != null) {
                                              File imageFile = File(imagePath!);

                                              adminHomeCubit
                                                  .updateImageInBannerFunction(
                                                bannerId: widget.bannerId,
                                                image: imageFile,
                                                imageId: homeCubit
                                                    .specificBannerModel!
                                                    .data!
                                                    .images![0]
                                                    .imageId!,
                                              );
                                            }
                                          },
                                          borderRadius: 10.r,
                                          text: AppLocalizations.of(context)!
                                              .submit,
                                          width: 335.w,
                                          height: 49.h,
                                        ),
                            ],
                          ),
                        ),
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
