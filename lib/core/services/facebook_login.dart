import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../notification/notification.dart';
import '../routes/route_name.dart';

class FacebookLogin{

 static Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
print(facebookAuthCredential.idToken);
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
 static Future<void> loginWithFacebook(BuildContext context) async {
   try {
     final userCredential = await signInWithFacebook();

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
     }

   }catch (e) {
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
