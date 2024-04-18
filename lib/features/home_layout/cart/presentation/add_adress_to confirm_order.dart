import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_phone_text_field.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_field_connect_us.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class AddAdressToConfirmOrder extends StatefulWidget {
  AddAdressToConfirmOrder({Key? key}) : super(key: key);

  @override
  State<AddAdressToConfirmOrder> createState() =>
      _AddAdressToConfirmOrderState();
}

class _AddAdressToConfirmOrderState extends State<AddAdressToConfirmOrder> {
  TextEditingController controller = TextEditingController();

  List<String> list = [
    "فرع الشرقية",
    "فرع الزقازيق",
    "فرع القاهره",
    "فرع الجيزة",
  ];

  // Option 2
  String? selectItem;

  String? newf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.addnewadress,
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .thenameofthissiteforexampleis,
                    ),
                  ],
                ),
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextFormFiled(
                        label: " ",
                        controller: controller,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.thenameofthissiteforexampleis}";
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            Text(
                                AppLocalizations.of(context)!.locationindetail),
                          ],
                        ),
                      ),
                      CustomTextFormFiled(
                        label: " ",
                        controller: controller,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.locationindetail}";
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            Text(AppLocalizations.of(context)!
                                .thephonenumberatthelocation),
                          ],
                        ),
                      ),
                      CustomPhoneTextField(
                        text: " ",
                        controller: controller,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.thephonenumberatthelocation}";
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            Text(AppLocalizations.of(context)!.city),
                          ],
                        ),
                      ),
                      CustomTextFormFiled(
                        label: " ",
                        controller: controller,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.city}";
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            Text(AppLocalizations.of(context)!.zipcountry),
                          ],
                        ),
                      ),
                      CustomTextFormFiled(
                        label: " ",
                        controller: controller,
                        validator: (text) {
                          if (text!.isEmpty || text == null) {
                            return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.zipcountry}";
                          }
                        },
                      ),
                    ],
                  )),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.pleaseselectthebranch,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    elevation: 1.sign,
                    isExpanded: true,
                    hint: Text(
                      AppLocalizations.of(context)!.choosebranch,
                    ),
                    // Not necessary for Option 1
                    value: selectItem,
                    onChanged: (newValue) {
                      setState(() {
                        selectItem = newValue;
                        newf = newValue;
                      });
                    },
                    items: list.map((item) {
                      return DropdownMenuItem(
                        child: new Text(
                          item,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        value: item,
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 10.w, right: 10.w, top: 30.h, bottom: 20.h),
                child: CustomTextFormFieldConnectUs(
                  label:
                      AppLocalizations.of(context)!.deliverynotestothisaddress,
                  controller: controller,
                  maxLines: 3,
                  validator: (p0) {

                  },
                ),
              ),
              CustomButtonWidget(
                height: 48.h,
                width: 274.w,
                text: AppLocalizations.of(context)!.confirm,
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
