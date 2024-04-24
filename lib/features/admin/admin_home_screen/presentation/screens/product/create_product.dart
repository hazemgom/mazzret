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

class CreateProduct extends StatefulWidget {
  Map data;

  CreateProduct({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  TextEditingController titleController = TextEditingController();
  TextEditingController titleArController = TextEditingController();

  TextEditingController priceNormalController = TextEditingController();
  TextEditingController priceWholesaleController = TextEditingController();

  TextEditingController quantityController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController descriptionArController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  String? imagePath;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        if (state is CreateProductSuccessState) {
          Navigator.pushReplacementNamed(
              context, RouteName.adminHomeLayoutRoute);
          BlocProvider.of<HomeCubit>(context).getAllProductsFunction();
          return CustomSnackBar.showMessage(
            context,
            message: 'تمت أضافة منتج جديد بنجاح',
            messageColor: AppColors.primaryColor,
          );
        } else if (state is CreateProductErrorState) {
          return CustomSnackBar.showMessage(
            context,
            message: 'حدثت مشكلة أثناء أضافة منتج جديد',
            messageColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        var adminCubit = AdminHomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: Text(
              AppLocalizations.of(context)!.addnewProduct,
              style: AppFonts.titleScreen.copyWith(height: 0),
            ),
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 40.h, left: 20.w, right: 20.w, bottom: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Text(
                        AppLocalizations.of(context)!.nameOfProduct,
                        style: AppFonts.black2Text.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    CustomTextFormFiled(
                      label: AppLocalizations.of(context)!.nameOfProduct,
                      readOnly: false,

                      controller: titleController,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'برجاء ملئ هذا الحقل';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Text(
                        AppLocalizations.of(context)!.nameOfProductInArabic,
                        style: AppFonts.black2Text.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    CustomTextFormFiled(
                      label: AppLocalizations.of(context)!.nameOfProductInArabic,
                      readOnly: false,
                      controller: titleArController,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'برجاء ملئ هذا الحقل';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Text(
                        AppLocalizations.of(context)!.priceNormal,
                        style: AppFonts.black2Text.copyWith(fontSize: 16.sp),
                      ),
                    ),
                    CustomTextFormFiled(
                      label: AppLocalizations.of(context)!.price,
                      controller: priceNormalController,
                      keyboardType: TextInputType.number,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'برجاء ملئ هذا الحقل';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Text(
                        AppLocalizations.of(context)!.priceWholesale,
                        style: AppFonts.black2Text.copyWith(fontSize: 16.sp),
                      ),
                    ),
                    CustomTextFormFiled(
                      label: AppLocalizations.of(context)!.price,
                      controller: priceWholesaleController,
                      keyboardType: TextInputType.number,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'برجاء ملئ هذا الحقل';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Text(
                        AppLocalizations.of(context)!.quantity,
                        style: AppFonts.black2Text.copyWith(fontSize: 16.sp),
                      ),
                    ),
                    CustomTextFormFiled(
                      label: AppLocalizations.of(context)!.quantity,
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'برجاء ملئ هذا الحقل';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Text(
                        AppLocalizations.of(context)!.category,
                        style: AppFonts.black2Text.copyWith(fontSize: 16.sp),
                      ),
                    ),
                    CustomTextFormFiled(
                      label: widget.data['text'],
                      controller: categoryController,
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Text(
                        AppLocalizations.of(context)!.description,
                        style: AppFonts.black2Text.copyWith(fontSize: 16.sp),
                      ),
                    ),
                    CustomTextFormFiled(
                      label: AppLocalizations.of(context)!.description,
                      controller: descriptionController,
                      // validator: (p0) {
                      //   if (p0!.isEmpty) {
                      //     return 'برجاء ملئ هذا الحقل';
                      //   }
                      // },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Text(
                        AppLocalizations.of(context)!.descriptionInArabic,
                        style: AppFonts.black2Text.copyWith(fontSize: 16.sp),
                      ),
                    ),
                    CustomTextFormFiled(
                      label: AppLocalizations.of(context)!.descriptionInArabic,
                      controller: descriptionArController,
                      // validator: (p0) {
                      //   if (p0!.isEmpty) {
                      //     return 'برجاء ملئ هذا الحقل';
                      //   }
                      // },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Text(
                        AppLocalizations.of(context)!.uploadimage,
                        style: AppFonts.black2Text.copyWith(fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 200.h,
                            width: 260.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                width: 2.w,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            child: imagePath != null
                                ? Image.file(
                                    File(imagePath!),
                                    fit: BoxFit.cover,
                                  )
                                : Lottie.asset(AppAssets.uploadImage),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 10.h),
                      child: state is CreateProductLoadingState
                          ? const Center(
                              child: CustomLoading(),
                            )
                          : CustomButtonWidget(
                              text: AppLocalizations.of(context)!.submit,
                              width: 335.w,
                              height: 49.h,
                              borderRadius: 10.r,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (imagePath != null) {
                                    File imageFile = File(imagePath!);

                                    adminCubit.createProductFunction(
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      quantity: quantityController.text,
                                      priceNormal: priceNormalController.text,
                                      priceWholesale: priceWholesaleController.text,
                                      descriptionAr: descriptionArController.text,
                                      titleAr: titleArController.text,
                                      categoryId:
                                          widget.data['categoryId'].toString(),
                                      image: imageFile,
                                    );
                                  } else {
                                    return CustomSnackBar.showMessage(
                                      context,
                                      message:
                                          'يجب عليك أضافة صورة للمنتج أولا!',
                                      messageColor: Colors.red,
                                    );
                                  }
                                }
                              },
                            ),
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
