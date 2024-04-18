import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/managers/profile_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_field_connect_us.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class MessageConnectWhithUs extends StatefulWidget {
  MessageConnectWhithUs({Key? key}) : super(key: key);

  @override
  State<MessageConnectWhithUs> createState() => _MessageConnectWhithUsState();
}

class _MessageConnectWhithUsState extends State<MessageConnectWhithUs> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController namecontroller = TextEditingController();

  TextEditingController messagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.connectwithus,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Text(
                  AppLocalizations.of(context)!.fullname,
                  style: AppFonts.blackText,
                ),
                SizedBox(height: 16.h),
                CustomTextFormFieldConnectUs(
                  controller: namecontroller,
                  maxLines: 1,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.name}";
                    }
                  },
                ),
                SizedBox(height: 24.h),
                Text(AppLocalizations.of(context)!.message,
                    style: AppFonts.blackText),
                SizedBox(
                  height: 16.h,
                ),
                CustomTextFormFieldConnectUs(
                  label: AppLocalizations.of(context)!.enteryourmessage,
                  controller: messagecontroller,
                  maxLines: 7,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.message}";
                    }
                  },
                ),
                SizedBox(height: 20.h),
                BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is SendMessageToAdminSuccessState) {
                      CustomSnackBar.showMessage(
                        context,
                        message: AppLocalizations.of(context)!
                            .themessagewassentsuccessfully,
                        messageColor: AppColors.primaryColor,
                      );
                      namecontroller.text = '';
                      messagecontroller.text = '';
                    } else if (state is SendMessageToAdminErrorState) {
                      CustomSnackBar.showMessage(
                        context,
                        message: AppLocalizations.of(context)!
                            .aproblemoccurredwhilesendingthemessage,
                        messageColor: Colors.red
                      );
                    }
                  },
                  builder: (context, state) {
                    var profileCubit = ProfileCubit.get(context);

                    return state is SendMessageToAdminLoadingState
                        ? const Center(child: CustomLoading())
                        : CustomButtonWidget(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await profileCubit.sendMessageToAdminFunction(
                                  name: namecontroller.text,
                                  messageContent: messagecontroller.text,
                                );
                              }
                            },
                            borderRadius: 10.r,
                            text: AppLocalizations.of(context)!.confirm,
                            width: 335.w,
                            height: 49.h,
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
