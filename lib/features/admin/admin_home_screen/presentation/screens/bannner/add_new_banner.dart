import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/managers/admin_home_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class AdminAddNewBanner extends StatefulWidget {
  const AdminAddNewBanner({Key? key}) : super(key: key);

  @override
  State<AdminAddNewBanner> createState() => _AdminAddNewBannerState();
}

class _AdminAddNewBannerState extends State<AdminAddNewBanner> {
  String? imagePath;
  String? imagePath2;
  String? imagePath3;
  String? imagePath4;
  String? imagePath5;
  String? imagePath6;
  String? imagePath7;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _pickImage2() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath2 = pickedFile.path;
      });
    }
  }

  Future<void> _pickImage3() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath3 = pickedFile.path;
      });
    }
  }

  Future<void> _pickImage4() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath4 = pickedFile.path;
      });
    }
  }

  Future<void> _pickImage5() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath5 = pickedFile.path;
      });
    }
  }

  Future<void> _pickImage6() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath6 = pickedFile.path;
      });
    }
  }

  Future<void> _pickImage7() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath7 = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminHomeCubit, AdminHomeState>(
      listener: (context, state) {
        if (state is CreateBannerSuccessState) {
          BlocProvider.of<HomeCubit>(context).getBanners();
          Navigator.pushReplacementNamed(
              context, RouteName.adminHomeLayoutRoute);
          return CustomSnackBar.showMessage(
            context,
            message: 'تمت عملية الأضافة بنجاح',
            messageColor: AppColors.primaryColor,
          );
        } else if (state is CreateBannerErrorState) {
          return CustomSnackBar.showMessage(
            context,
            message: 'حدثت مشكلة أثناء أضافة لافتة جديدة',
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
              AppLocalizations.of(context)!.addnewbanner,
              style: AppFonts.titleScreen.copyWith(height: 0),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 150.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          child: imagePath != null
                              ? Image.file(
                                  File(imagePath!),
                                  fit: BoxFit.cover,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      AppAssets.addbannerImage,
                                      width: 60.w,
                                      height: 60.h,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      AppLocalizations.of(context)!.addnewbanner,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _pickImage2,
                        child: Container(
                          height: 150.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          child: imagePath2 != null
                              ? Image.file(
                                  File(imagePath2!),
                                  fit: BoxFit.cover,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      AppAssets.addbannerImage,
                                      width: 60.w,
                                      height: 60.h,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      AppLocalizations.of(context)!.addnewbanner,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: _pickImage3,
                        child: Container(
                          height: 150.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          child: imagePath3 != null
                              ? Image.file(
                            File(imagePath3!),
                            fit: BoxFit.cover,
                          )
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                AppAssets.addbannerImage,
                                width: 60.w,
                                height: 60.h,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                AppLocalizations.of(context)!.addnewbanner,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.primaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _pickImage4,
                        child: Container(
                          height: 150.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          child: imagePath4 != null
                              ? Image.file(
                            File(imagePath4!),
                            fit: BoxFit.cover,
                          )
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                AppAssets.addbannerImage,
                                width: 60.w,
                                height: 60.h,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                AppLocalizations.of(context)!.addnewbanner,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.primaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: _pickImage5,
                        child: Container(
                          height: 150.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          child: imagePath5 != null
                              ? Image.file(
                                  File(imagePath5!),
                                  fit: BoxFit.cover,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      AppAssets.addbannerImage,
                                      width: 60.w,
                                      height: 60.h,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      AppLocalizations.of(context)!.addnewbanner,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _pickImage6,
                        child: Container(
                          height: 150.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          child: imagePath6 != null
                              ? Image.file(
                                  File(imagePath6!),
                                  fit: BoxFit.cover,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      AppAssets.addbannerImage,
                                      width: 60.w,
                                      height: 60.h,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      AppLocalizations.of(context)!.addnewbanner,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _pickImage7,
                        child: Container(
                          height: 150.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          child: imagePath7 != null
                              ? Image.file(
                            File(imagePath7!),
                            fit: BoxFit.cover,
                          )
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                AppAssets.addbannerImage,
                                width: 60.w,
                                height: 60.h,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                AppLocalizations.of(context)!.addnewbanner,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.primaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  state is CreateBannerLoadingState
                      ? const Center(
                          child: CustomLoading(),
                        )
                      : CustomButtonWidget(
                          height: 48.h,
                          width: 227,
                          text: AppLocalizations.of(context)!.submit,
                          onPressed: () {
                            if (imagePath != null) {
                              File imageFile = File(imagePath!);
                              File imageFile2 = File(imagePath2!);
                              File imageFile3 = File(imagePath3!);
                              File imageFile4 = File(imagePath4!);
                              File imageFile5 = File(imagePath5!);
                              File imageFile6 = File(imagePath6!);
                              File imageFile7 = File(imagePath7!);
                              // print(imageFile);
                              // print(imageFile2);
                              // print(imageFile3);
                              // print(imageFile4);
                              // print(imageFile5);
                              // print(imageFile6);
                              // print(imageFile7);
                              adminHomeCubit.createBannerFunction(
                                imageFile,
                                imageFile2,
                                imageFile3,
                                imageFile4,
                                imageFile5,
                                imageFile6,
                                imageFile7,
                              );
                            } else {
                              return CustomSnackBar.showMessage(
                                context,
                                message: 'يجب أضافة صورة لللافتة',
                                messageColor: Colors.red,
                              );
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
