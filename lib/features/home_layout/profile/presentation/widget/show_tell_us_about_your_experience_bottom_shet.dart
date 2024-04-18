import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/features/home_layout/profile/managers/profile_cubit.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_loading.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_stackbar.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_field_connect_us.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';

class ShowTellUsAboutYourExperienceBottomSheet extends StatefulWidget {
  ShowTellUsAboutYourExperienceBottomSheet({Key? key, required this.controller})
      : super(key: key);
  TextEditingController controller = TextEditingController();

  @override
  State<ShowTellUsAboutYourExperienceBottomSheet> createState() =>
      _ShowTellUsAboutYourExperienceBottomSheetState();
}

class _ShowTellUsAboutYourExperienceBottomSheetState
    extends State<ShowTellUsAboutYourExperienceBottomSheet> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24.w,
            right: 24.w,
            top: 16.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      AppAssets.exitIcon,
                    ),
                  ),
                ],
              ),
              Text(
                AppLocalizations.of(context)!.shareyourthoughtsonourapp,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Text(
                  AppLocalizations.of(context)!.helpus,
                  style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
                ),
              ),
              CustomTextFormFieldConnectUs(
                controller: widget.controller,
                label: AppLocalizations.of(context)!.tellusaboutyourexperience,
                maxLines: 5,
                validator: (p0) {},
              ),
              SizedBox(
                height: 32.h,
              ),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is SendFeedBackToAdminSuccessState) {
                    Navigator.pop(context);
                    widget.controller.text = '';
                  } else if (state is SendFeedBackToAdminErrorState) {
                    CustomSnackBar.showMessage(
                      context,
                      message: AppLocalizations.of(context)!
                          .therewasaproblemsendingyourcomment,
                      messageColor: Colors.red,
                    );
                  }
                },
                builder: (context, state) {
                  var feedBackCubit = ProfileCubit.get(context);

                  return state is SendFeedBackToAdminLoadingState
                      ? const Center(
                          child: CustomLoading(),
                        )
                      : CustomButtonWidget(
                          height: 46.h,
                          width: 330.w,
                          text: AppLocalizations.of(context)!.sendfeedback,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await feedBackCubit.sendFeedBackToAdminFunction(
                                feedback: widget.controller.text,
                              );
                            }
                          },
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
