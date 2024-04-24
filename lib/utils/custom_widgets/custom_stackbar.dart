import 'package:flutter/material.dart';
import 'package:mozart_flutter_app/utils/styles/fonts.dart';

class CustomSnackBar {
  CustomSnackBar(BuildContext context);

  static void showMessage(BuildContext context, {required String message, required Color messageColor}) {
    final snackBar = SnackBar(
      backgroundColor: messageColor,
      content: Text(
        message,
        style: AppFonts.snackbarText,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
