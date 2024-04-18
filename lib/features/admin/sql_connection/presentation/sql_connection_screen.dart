import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_routes.dart';
import 'package:mozart_flutter_app/features/admin/sql_connection/presentation/widgets/checkbox/check_box.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_botton.dart';
import 'package:mozart_flutter_app/utils/custom_widgets/custom_text_form_filed.dart';
import 'package:mozart_flutter_app/utils/styles/colors.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'choice_screen.dart';

class SqlConnectionScreen extends StatefulWidget {
  const SqlConnectionScreen({super.key});

  @override
  State<SqlConnectionScreen> createState() => _SqlConnectionScreenState();
}

class _SqlConnectionScreenState extends State<SqlConnectionScreen> {
  bool isMale = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController serverNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dbNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'SQL-Connection',
          style: AppFonts.titleScreen.copyWith(height: 0),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                /// Check on Yes - No
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text(
                        'تفعيل المزامنة مع قواعد البيانات؟',
                        style: GoogleFonts.cairo(fontSize: 16.sp),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Custom CheckBox
                          CustomCheckBox(
                            onPressed: () => setState(() => isMale = true),
                            borderColor:
                            isMale ? AppColors.primaryColor : Colors.grey,
                            checkIconWidget: isMale
                                ? Icon(Icons.check,
                                size: 18.sp, color: AppColors.primaryColor)
                                : Container(),
                            textForCheckBox: Text('نعم',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                    color: isMale
                                        ? AppColors.primaryColor
                                        : Colors.black,
                                    fontWeight: isMale
                                        ? FontWeight.w600
                                        : FontWeight.w600,
                                    fontSize: 16.sp)),
                          ),
                          SizedBox(width: 26.w),
                          CustomCheckBox(
                            onPressed: () => setState(() => isMale = false),
                            borderColor:
                            isMale ? Colors.grey : AppColors.primaryColor,
                            checkIconWidget: isMale
                                ? Container()
                                : Icon(Icons.check,
                                size: 18.sp, color: AppColors.primaryColor),
                            textForCheckBox: Text('لا',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                    color: isMale
                                        ? Colors.black
                                        : AppColors.primaryColor,
                                    fontWeight: isMale
                                        ? FontWeight.w500
                                        : FontWeight.w600,
                                    fontSize: 16.sp)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ), // Additional
                const Divider(),
                /// Form
                isMale ? Column(
                  children: [
                    /// ServerName - UserName - Password - DBName
                    CustomTextFormFiled(
                      textDirection: TextDirection.ltr,
                      label: AppLocalizations.of(context)!.serverName,
                      controller: serverNameController,
                      validator: (text) {
                        if (text!.isEmpty || text == null) {
                          return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.name}";
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormFiled(
                      textDirection: TextDirection.ltr,
                      label: AppLocalizations.of(context)!.userName,
                      controller: userNameController,
                      validator: (text) {
                        if (text!.isEmpty || text == null) {
                          return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.name}";
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormFiled(
                      textDirection: TextDirection.ltr,
                      label: AppLocalizations.of(context)!.password,
                      controller: passwordController,
                      validator: (text) {
                        if (text!.isEmpty || text == null) {
                          return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.name}";
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormFiled(
                      textDirection: TextDirection.ltr,
                      label: AppLocalizations.of(context)!.dbName,
                      controller: dbNameController,
                      validator: (text) {
                        if (text!.isEmpty || text == null) {
                          return "${AppLocalizations.of(context)!.pleaseenteryour} ${AppLocalizations.of(context)!.name}";
                        }
                      },
                    ),
                    SizedBox(height: 20.h),

                    /// Button
                    CustomButtonWidget(
                      onPressed: () {

                        print(isMale);
                        print(serverNameController.text);
                        print(userNameController.text);
                        print(passwordController.text);
                        print(dbNameController.text);
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ChoiceScreenAfterSQLConnection(
                            user: userNameController.text??'as',
                            server: serverNameController.text??'DESKTOP-NDRHRIF',
                            database:dbNameController.text??'OnlineStore',
                            password: passwordController.text??'sql2001',
                          );
                        }));
                      },
                      borderRadius: 10.r,
                      text: AppLocalizations.of(context)!.save,
                      width: 335.w,
                      height: 49.h,
                    )
                  ],
                ) : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
