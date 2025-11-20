import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_essac/core/notification/notification.dart';
import 'package:task_essac/core/reusable_widget/buttons.dart';
import 'package:task_essac/core/routes/route_name.dart';

import '../../../../core/services/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Button(
            onPressed: () async {
              GoogleSingInAuthCustom.loginWithGoogle(context);
            },
            text: "Sign In With Google",
          ),
        ],
      ),
    );
  }
}
