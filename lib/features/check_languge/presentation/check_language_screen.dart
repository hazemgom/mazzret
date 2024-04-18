import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/auth/presentation/screens/register_screen.dart';
import 'package:mozart_flutter_app/provider/provider.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_back_for_app.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckLangugeScreen extends StatefulWidget {
  const CheckLangugeScreen({Key? key}) : super(key: key);

  @override
  State<CheckLangugeScreen> createState() => _CheckLangugeScreenState();
}

class _CheckLangugeScreenState extends State<CheckLangugeScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        showAdaptiveDialog(
          context: context,
          builder: (context) => CustomBackForAppBar(
            text: AppLocalizations.of(context)!.doyouwanttoexit,
            onPressed: () {
              SystemNavigator.pop();
            },
            text2: AppLocalizations.of(context)!.exit,
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            AppLocalizations.of(context)!.language,
            style: AppFonts.titleScreen,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.chooselanguage,
                style: AppFonts.titleScreen
                    .copyWith(color: AppColors.primaryColor),
              ),
              CustomButtonWidget(
                onPressed: () {
                  setState(() {
                    provider.changeAppLanguage("ar");
                    Navigator.pushReplacementNamed(
                        context, RouteName.loginRoute);
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                  });
                },
                borderRadius: 10.r,
                text: AppLocalizations.of(context)!.arabic,
                width: 227.w,
                height: 49.h,
              ),
              CustomButtonWidget(
                onPressed: () {
                  setState(() {
                    provider.changeAppLanguage("en");
                    Navigator.pushReplacementNamed(
                        context, RouteName.loginRoute);
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                  });
                },
                borderRadius: 10.r,
                text: AppLocalizations.of(context)!.english,
                width: 227.w,
                height: 49.h,
              ),
              SizedBox(
                height: 80.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
