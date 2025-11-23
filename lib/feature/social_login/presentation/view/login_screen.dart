import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_essac/core/reusable_widget/buttons.dart';
import '../../../../core/services/facebook_login.dart';
import '../../../../core/services/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login With Social Media",
          style: GoogleFonts.aBeeZee(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Button(
              color: Color(0xffc26f6c),
              onPressed: () async {
                GoogleSingInAuthCustom.loginWithGoogle(context);
              },
              style: GoogleFonts.aBeeZee(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              text: "Sign In With Google",
            ),
            Button(
              color: Color(0xffc26f6c),

              onPressed: () async {
                FacebookLogin.loginWithFacebook(context);
              },
              text: "Sign In With Facebook",
              style: GoogleFonts.aBeeZee(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
