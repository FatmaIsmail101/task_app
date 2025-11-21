import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../notification/notification.dart';
import '../routes/route_name.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class GoogleSingInAuthCustom {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize(
        serverClientId: dotenv.env['SERVER_CLIENT_ID'],
      );
      final GoogleSignInAccount result = await _googleSignIn.authenticate();
      final googleAuth = result.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("Error $e");
      return null;
    }
  }

  static Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final userCredential = await signInWithGoogle();

      if (userCredential != null) {
        // تسجيل الدخول نجح
        NotificationBar.showNotification(
          message: "Successfully logged in",
          type: ContentType.success,
          context: context,
          icon: Icons.check,
        );

        // الانتقال للشاشة التالية
        Navigator.pushNamed(context, RouteName.settingScreen);
      } else {
        // المستخدم ألغى أو تسجيل الدخول فشل
        NotificationBar.showNotification(
          message: "Login failed or cancelled",
          type: ContentType.failure,
          context: context,
          icon: Icons.error,
        );
      }
    } catch (e) {
      // لو حصل خطأ غير متوقع
      NotificationBar.showNotification(
        message: "An error occurred: $e",
        type: ContentType.failure,
        context: context,
        icon: Icons.error,
      );
    }
  }
}
