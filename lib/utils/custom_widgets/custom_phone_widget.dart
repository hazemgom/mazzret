import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomFormField extends StatefulWidget {
  final String hintText;
  final bool obsecureText;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextEditingController codeControlere;

  final Function(String)? onChanged;

  final String? Function(String?)? validator;

  const CustomFormField({
    Key? key,
    required this.hintText,
    required this.obsecureText,
    this.suffixIcon,
    required this.textInputType,
    required this.controller,
    this.validator,
    this.onChanged,
    required this.codeControlere,
  }) : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  Country? countrys;

  @override
  Widget build(BuildContext context) {
    String flag = AppAssets.lb;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFormFiled(
                keyboardType: widget.textInputType,
                hintText: widget.hintText,
                label: widget.hintText,
                controller: widget.controller,
                validator: widget.validator,
                suffixIcon: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Row(
                    children: [
                      countrys != null
                          ? Expanded(
                              child: Text(
                                "${countrys!.name.toString()} (+${countrys!.phoneCode})",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.cairo(
                                  color: AppColors.grey,
                                  fontSize: 12.sp,
                                ),
                              ),
                            )
                          : Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.libyaKey,
                                style: GoogleFonts.cairo(
                                  color: AppColors.grey,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                      InkWell(
                        child: countrys != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  countrys!.flagEmoji,
                                  style: const TextStyle(
                                    fontSize: 23,
                                  ),
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "🇱🇾",
                                  style: TextStyle(
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              exclude: ["IL"],
                              favorite: ["LY", "EG"],
                              onSelect: (Country country) {
                                setState(() {
                                  countrys = country;
                                  widget.codeControlere.text =
                                      country.phoneCode;
                                });
                                flag = country.flagEmoji;
                              }
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  countrys != null
                      ? Text(
                          "${countrys!.name.toString()} (+${countrys!.phoneCode})",
                          style: GoogleFonts.cairo(
                            color: AppColors.grey,
                            fontSize: 12.sp,
                          ),
                        )
                      : Text(
                    AppLocalizations.of(context)!.libyaKey,
                          style: GoogleFonts.cairo(
                            color: AppColors.grey,
                            fontSize: 12.sp,
                          ),
                        )
                  // style: getMediumStyle(
                  //     color: ColorManger.text4, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        // InkWell(
        //   child: countryss != null
        //       ? Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Text(
        //             countryss!.flagEmoji,
        //             style: const TextStyle(
        //               fontSize: 23,
        //             ),
        //           ),
        //         )
        //       : const Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Text(
        //             "🇸🇦",
        //             style: TextStyle(
        //               fontSize: 23,
        //             ),
        //           ),
        //         ),
        //   onTap: () {
        //     showCountryPicker(
        //         context: context,
        //         showPhoneCode: true,
        //         exclude: ["IL"],
        //         favorite: ["SA", "EG"],
        //         onSelect: (Country country) {
        //           setState(() {
        //             countryss = country;
        //             widget.codeControlere.text = country.phoneCode;
        //             // widget.contrycode = country.phoneCode;
        //           });
        //           print(country.flagEmoji.toString());
        //           flag = country.flagEmoji;
        //         }
        //         // provider.changeCountry(country),
        //         );
        //   },
        // ),
      ],
    );
  }
}
