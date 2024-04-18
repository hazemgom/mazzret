import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
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
import 'package:mozart_flutter_app/utils/custom_widgets/cache_image.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class AdminEditCategory extends StatefulWidget {
  String categoryId;
  String name;
  String nameAr;
  String image;

  AdminEditCategory({
    Key? key,
    required this.categoryId,
    required this.name,
    required this.nameAr,
    required this.image,
  }) : super(key: key);

  @override
  State<AdminEditCategory> createState() => _AdminEditCategoryState();
}

class _AdminEditCategoryState extends State<AdminEditCategory> {
  TextEditingController controller = TextEditingController();
  TextEditingController controllerAr = TextEditingController();
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
  void initState() {
    controller.text=widget.name;
    controllerAr.text=widget.nameAr;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit()..getSpecificCategory(categoryId: widget.categoryId),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);

          return BlocConsumer<AdminHomeCubit, AdminHomeState>(
            listener: (context, state) {
              if (state is UpdateImageOfCategorySuccessState) {
                Navigator.pushReplacementNamed(
                    context, RouteName.adminHomeLayoutRoute);
                BlocProvider.of<HomeCubit>(context).getCategoryList();
                return CustomSnackBar.showMessage(
                  context,
                  message: 'تمت عملية التعديل بنجاح',
                  messageColor: AppColors.primaryColor,
                );
              } else if (state is UpdateImageOfCategoryErrorState) {
                return CustomSnackBar.showMessage(
                  context,
                  message: 'حدثت مشكلة أثناء تعديل الفئة',
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
                    AppLocalizations.of(context)!.update,
                    style: AppFonts.titleScreen.copyWith(height: 0),
                  ),
                  centerTitle: true,
                ),
                body: homeCubit.specificCategoryModel == null
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
                                            height: 100.h,
                                            width: 200.w,
                                            fit: BoxFit.cover,
                                          )
                                        : CachedImage(
                                            link: homeCubit
                                                .specificCategoryModel!
                                                .data!
                                                .image!
                                                .url,
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
                                SizedBox(height: 30.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: CustomTextFormFiled(
                                    label: 'ادخل الأسم الخاص بالفئة بالعربية',
                                    keyboardType: TextInputType.name,
                                    hintText: 'ادخل الأسم الخاص بالفئة بالعربية',
                                    controller: controllerAr,
                                    validator: (p0) {
                                      if (p0!.isEmpty) {
                                        return 'برجاء ملئ هذا الحقل لتحديث أسم الفئة';
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 10.w),
                                  child: CustomTextFormFiled(
                                    label: 'ادخل الأسم الخاص بالفئة بالأنجليزية',
                                    keyboardType: TextInputType.name,
                                    hintText: 'ادخل الأسم الخاص بالفئة بالأنجليزية',
                                    controller: controller,
                                    validator: (p0) {
                                      if (p0!.isEmpty) {
                                        return 'برجاء ملئ هذا الحقل لتحديث أسم الفئة';
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 30.h),
                                CustomButtonWidget(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      if (imagePath != null) {
                                        // User has selected a new image
                                        File imageFile = File(imagePath!);
                                        adminHomeCubit.updateCategoryImageFunction(
                                          categoryId: widget.categoryId,
                                          image: imageFile,
                                          name: controller.text,
                                          nameAr: controllerAr.text,
                                        );
                                      } else {
                                        // User has not selected a new image, download the old image
                                        var response = await http.get(Uri.parse(widget.image));
                                        var directory = await getTemporaryDirectory();
                                        var filePath = '${directory.path}/category_image.jpg';
                                        File imageFile = File(filePath);
                                        await imageFile.writeAsBytes(response.bodyBytes);
                                        adminHomeCubit.updateCategoryImageFunction(
                                          categoryId: widget.categoryId,
                                          image: imageFile,
                                          name: controller.text,
                                          nameAr: controllerAr.text,
                                        );
                                      }
                                    }
                                  },
                                  borderRadius: 10.r,
                                  text: AppLocalizations.of(context)!.submit,
                                  width: 335.w,
                                  height: 49.h,
                                )

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
