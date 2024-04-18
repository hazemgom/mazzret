import 'dart:io';


import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart ';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/admin_home_screen/managers/admin_home_cubit.dart';
import 'package:mozart_flutter_app/features/home_layout/home/data/models/specific_product_model.dart'as ProductModel;

import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';


class EditToProduct extends StatefulWidget {
  final String productId;
  final String title;
  final String titleAr;
  final String description;
  final String descriptionAr;
  final dynamic quantity;
  final dynamic priceNormal;
  final dynamic priceWholesale;
  const EditToProduct({
    Key? key,
    required this.productId, required this.title,required this.titleAr,
    required this.description,required this.descriptionAr,required this.quantity,
    required this.priceNormal,
    required this.priceWholesale



  }) : super(key: key);

  @override
  State<EditToProduct> createState() => _EditToProductState();
}

class _EditToProductState extends State<EditToProduct> {
  String? imagePath;
  TextEditingController nameOfProductController = TextEditingController();
  TextEditingController nameArOfProductController = TextEditingController();
  TextEditingController descriptionOfProductController =
  TextEditingController();
  TextEditingController descriptionArOfProductController =
  TextEditingController();
  TextEditingController quantityOfProductController = TextEditingController();

  TextEditingController categoryOfProductController = TextEditingController();

  TextEditingController priceNormalController = TextEditingController();
  TextEditingController priceWholesaleController = TextEditingController();

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
  void initState() {
    print( nameOfProductController.text = widget.title??'');
    nameOfProductController.text = widget.title??'';
    nameArOfProductController.text = widget.titleAr??'';
    descriptionOfProductController.text = widget.description ?? '';
    descriptionArOfProductController.text = widget.descriptionAr ?? '';
    quantityOfProductController.text = widget.quantity.toString();
    priceNormalController.text = widget.priceNormal.toString();
    priceWholesaleController.text =widget.priceWholesale.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      HomeCubit()..getSpecificProductFunction(productId: widget.productId),
      child: BlocConsumer<AdminHomeCubit, AdminHomeState>(
        listener: (context, state) {


          if (state is EditSpecificProductSuccessState) {
            Navigator.pushReplacementNamed(
                context, RouteName.adminHomeLayoutRoute);
            return CustomSnackBar.showMessage(
              context,
              message: 'تمت عملية التعديل بنجاح',
              messageColor: AppColors.primaryColor,
            );
          }
        },
        builder: (context, state) {
          var adminHomeCubit = AdminHomeCubit.get(context);
          var cubit = HomeCubit.get(context);


          return BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {



              return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.primaryColor,
                  title: Text(
                    AppLocalizations.of(context)!.edit,
                    style: AppFonts.titleScreen.copyWith(height: 0),
                  ),
                  centerTitle: true,
                ),
                body: state is GetSpecificProductLoadingState ||
                    cubit.specificProductModel == null
                    ? const Center(
                  child: CustomLoading(),
                )
                    : Form(
                  key: formKey,
                  child: SingleChildScrollView(
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
                                height: 200.h,
                                width: 200.w,
                                fit: BoxFit.cover,
                              )
                                  : CachedImage(
                                link: cubit.specificProductModel!
                                    .data!.image!.url,
                                width: 200.w,
                                height: 100.h,
                                borderRadius: 12.r,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'أضغط علي الصورة لتغيرها',
                            style: GoogleFonts.cairo(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20.h),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 10.w),
                                child: CustomTextFormFiled(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  label: 'العنوان باللغة العربية',
                                  keyboardType: TextInputType.name,

                                  controller: nameArOfProductController,
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return 'برجاء ملئ هذا الحقل لتحديث أسم الفئة';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 10.w),
                                child: CustomTextFormFiled(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  label: 'العنوان باللغة الانجليزية',
                                  keyboardType: TextInputType.name,
                                  hintText:
                                  cubit.specificProductModel!.data!.title,
                                  controller: nameOfProductController,
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return 'برجاء ملئ هذا الحقل لتحديث أسم الفئة';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 20.h),
                              cubit.specificProductModel!.data!
                                  .descriptionAr == null ? Container() : Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 10.w),
                                child: CustomTextFormFiled(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  label: 'تفاصيل المنتج باللغة العربية',
                                  keyboardType: TextInputType.name,
                                  hintText: cubit.specificProductModel!.data!
                                      .descriptionAr ?? '',
                                  controller:
                                  descriptionArOfProductController,
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return 'برجاء ملئ هذا الحقل لتحديث أسم الفئة';
                                    }
                                  },
                                ),
                              ),
                              cubit.specificProductModel!.data!
                                  .descriptionAr == null ? Container() : SizedBox(height: 20.h),

                              cubit.specificProductModel!.data!
                                  .description == null ? Container() : Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 10.w),
                                child: CustomTextFormFiled(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  label: 'تفاصيل المنتج باللغة الأنجليزية',
                                  keyboardType: TextInputType.name,
                                  hintText: cubit.specificProductModel!.data!
                                      .description,
                                  controller: descriptionOfProductController,
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return 'برجاء ملئ هذا الحقل لتحديث أسم الفئة';
                                    }
                                  },
                                ),
                              ),
                              cubit.specificProductModel!.data!
                                  .descriptionAr == null ? Container() : SizedBox(height: 20.h),

                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 10.w),
                                child: CustomTextFormFiled(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  label: 'الكمية',
                                  keyboardType: TextInputType.name,
                                  hintText: cubit
                                      .specificProductModel!.data!.quantity
                                      .toString(),
                                  controller: quantityOfProductController,
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return 'برجاء ملئ هذا الحقل لتحديث أسم الفئة';
                                    }
                                  },
                                ),
                              ),

                              SizedBox(height: 20.h),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 10.w),
                                child: CustomTextFormFiled(
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  label: 'الكمية',
                                  keyboardType: TextInputType.name,
                                  hintText: cubit
                                      .specificProductModel!.data!.priceNormal
                                      .toString(),
                                  controller: priceNormalController,
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return 'برجاء ملئ هذا الحقل لتحديث أسم الفئة';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 10.w),
                            child: CustomTextFormFiled(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              label: 'السعر بالجملة',
                              keyboardType: TextInputType.name,
                              hintText: cubit.specificProductModel!.data!
                                  .priceWholesale
                                  .toString(),
                              controller: priceWholesaleController,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return 'برجاء ملئ هذا الحقل لتحديث أسم الفئة';
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 30.h),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 45,
                              padding: EdgeInsets.all(8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade800,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: MaterialButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    print('Validation successful. Proceeding to update.');

                                    adminHomeCubit.updateProduct(
                                      id: widget.productId,

                                      titleAr: nameArOfProductController.text,
                                      description: descriptionOfProductController.text,
                                      descriptionAr: descriptionArOfProductController.text,
                                      quantity: quantityOfProductController.text,
                                      priceNormal: priceNormalController.text,
                                      priceWholesale: priceWholesaleController.text,
                                    );
                                  } else {
                                    print('Validation failed.');
                                  }
                                },
                                child: Text('تعديل'),
                              ),

                            ),
                          ),

                        ],
                      ),
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
