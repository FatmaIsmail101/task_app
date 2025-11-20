import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class NotificationBar {
  static void showNotification({
    required String message,
    required ContentType type,
    required BuildContext context,
    required IconData icon,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: _getTitle(type)??"Success",
        message: message,
        contentType: type,
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // ⬇️ ⬇️ طلّعناها برا الدالة ⬇️ ⬇️
  static String? _getTitle(ContentType type) {
    switch (type) {
      case ContentType.success:
        return "Success!";
      case ContentType.failure:
        return "Error!";
      case ContentType.warning:
        return "Warning!";
      case ContentType.help:
        return "Note!";
    }
    return null;
  }
}
