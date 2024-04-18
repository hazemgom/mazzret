import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mozart_flutter_app/config/app_assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mozart_flutter_app/features/check_languge/presentation/check_language_screen.dart';
import 'package:mozart_flutter_app/provider/provider.dart';
import 'package:provider/provider.dart';

class CustomContainerProfile extends StatelessWidget {
  CustomContainerProfile({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  Widget icon;
  String text;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);

    return ListTile(
      leading: icon,
      title: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
      trailing: provider.appLanguage == 'en'
          ? SvgPicture.asset(
              AppAssets.arrowforward,
              color: Colors.grey.shade500,
            )
          : SvgPicture.asset(
              AppAssets.arrowbackIcon,
              color: Colors.grey.shade500,
            ),
    );
  }
}
