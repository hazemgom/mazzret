import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/provider/provider.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:provider/provider.dart';

class ShowLnguageBottomShet extends StatefulWidget {
  const ShowLnguageBottomShet({Key? key}) : super(key: key);

  @override
  State<ShowLnguageBottomShet> createState() => _ShowLanguageBottomSheetState();
}

class _ShowLanguageBottomSheetState extends State<ShowLnguageBottomShet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    var _result = provider.appLanguage;
    return SizedBox(
      height: 220.h,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Text(
              AppLocalizations.of(context)!.changelanguage,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ),
          const Divider(thickness: 1),
          RadioListTile(
              activeColor: AppColors.primaryColor,
              title: Text(AppLocalizations.of(context)!.arabic),
              value: 'ar',
              groupValue: _result,
              onChanged: (value) {
                setState(() {
                  _result = value!;
                  provider.changeAppLanguage("ar");
                  Navigator.pop(context);
                });
              }),
          RadioListTile(
              activeColor: AppColors.primaryColor,
              title: Text(AppLocalizations.of(context)!.english),
              value: 'en',
              groupValue: _result,
              onChanged: (value) {
                setState(() {
                  _result = value!;
                  provider.changeAppLanguage("en");
                  Navigator.pop(context);
                });
              }),
        ],
      ),
    );
  }
}
