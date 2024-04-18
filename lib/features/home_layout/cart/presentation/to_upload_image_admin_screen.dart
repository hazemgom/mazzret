import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/features/home_layout/home/managers/home_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UploadImageToAdminScreen extends StatefulWidget {
  String? productId;
  UploadImageToAdminScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<UploadImageToAdminScreen> createState() =>
      _UploadImageToAdminScreenState();
}

class _UploadImageToAdminScreenState extends State<UploadImageToAdminScreen> {
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
      create: (context) => HomeCubit()..getSpecificProductFunction(productId: widget.productId!),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) async {
          if (state is UploadImageToAdminSuccessState) {
            imagePath = null;
            Navigator.pop(context);
            CustomSnackBar.showMessage(
              context,
              message: AppLocalizations.of(context)!
                  .thesuggestedimagehasbeenuploadedsuccessfully,
              messageColor: AppColors.primaryColor,
            );
          } else if (state is UploadImageToAdminErrorState) {
            CustomSnackBar.showMessage(context,
                message: AppLocalizations.of(context)!.errorInUpload,
                messageColor: Colors.red);
          }
        },
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.primaryColor,
              title: Text(
                AppLocalizations.of(context)!.uploadImage,
                style: AppFonts.titleScreen,
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              centerTitle: true,
            ),
            body: homeCubit.specificProductModel == null
                ? const Center(
              child: CustomLoading(),
            )
                : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.uploadimage,
                        style: AppFonts.blackText.copyWith(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
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
                  SizedBox(
                    height: 5.h,
                  ),
                  state is UploadImageToAdminLoadingState
                      ? const Center(
                    child: CustomLoading(),
                  )
                      : CustomButtonWidget(
                    text: AppLocalizations.of(context)!.sendimage,
                    height: 48.h,
                    width: 247.w,
                    onPressed: () async {
                      if (imagePath != null) {
                        File imageFile = File(imagePath!);

                        homeCubit.uploadImageToServer(
                          imageFile,
                          homeCubit
                              .specificProductModel!.data!.title!,
                          homeCubit.specificProductModel!.data!.sId!,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
