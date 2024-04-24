import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminCreateCategory extends StatefulWidget {
  AdminCreateCategory({Key? key}) : super(key: key);

  @override
  State<AdminCreateCategory> createState() => _AdminCreateCategoryState();
}

class _AdminCreateCategoryState extends State<AdminCreateCategory> {
  TextEditingController controller = TextEditingController();
  TextEditingController controllerar = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    return BlocConsumer<AdminHomeCubit, AdminHomeState>(
      listener: (context, state) {
        if (state is CreateCategorySuccessState) {
          BlocProvider.of<HomeCubit>(context).getCategoryList();
          Navigator.pop(context);
          // Navigator.pushReplacementNamed(
          //     context, RouteName.adminHomeLayoutRoute);
          return CustomSnackBar.showMessage(
            context,
            message: 'تمت عملية الأضافة بنجاح',
            messageColor: AppColors.primaryColor,
          );
        } else if (state is CreateCategoryErrorState) {
          return CustomSnackBar.showMessage(
            context,
            message: 'حدثت مشكلة أثناء أضافة فئة جديدة',
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
              AppLocalizations.of(context)!.addnewcategory,
              style: AppFonts.titleScreen.copyWith(height: 0),
            ),
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .pleaseselectanimageforthecategory,
                      style: AppFonts.black2Text.copyWith(fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: imagePath != null
                            ? Image.file(
                                File(imagePath!),
                                fit: BoxFit.cover,
                              )
                            : Lottie.asset(
                                AppAssets.uploadImage2,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .pleaseselectannameforthecategory,
                      style: AppFonts.black2Text.copyWith(fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextFormFiled(
                      label: AppLocalizations.of(context)!.nameOfCategoryInArabic,
                      controller: controllerar,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'يجب ملئ هذا الحقل';
                        }
                      },
                    ),
                    CustomTextFormFiled(
                      label: AppLocalizations.of(context)!.nameOfCategoryInEnglish,
                      controller: controller,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'يجب ملئ هذا الحقل';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    state is CreateCategoryLoadingState
                        ? const Center(
                            child: CustomLoading(),
                          )
                        : CustomButtonWidget(
                            height: 48.h,
                            width: 227.w,
                            text: AppLocalizations.of(context)!.submit,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (imagePath != null) {
                                  File imageFile = File(imagePath!);
                                  adminHomeCubit.createCategoryFunction(
                                    image: imageFile,
                                    name: controller.text,
                                    nameAr: controllerar.text,
                                  );
                                } else {
                                  return CustomSnackBar.showMessage(
                                    context,
                                    message: 'يجب أضافة صورة للفئة',
                                    messageColor: Colors.red,
                                  );
                                }
                              }
                            },
                          )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
