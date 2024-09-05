import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/presentation/view/auth/login/login_view.dart';
import 'package:news_app/presentation/view/auth/sign_up/layout/body.dart';

import '../../../../configurations/frontend_configs.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                  text: "Already have an account?",
                  style: const TextStyle(
                      fontFamily: "EncodeSansSemiCondensed",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff4B5563)),
                  children: [
                    TextSpan(
                      text: " Login",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
                        },
                      style: TextStyle(
                          fontFamily: "EncodeSansSemiCondensed",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: FrontendConfigs.kAppPrimaryColor),
                    )
                  ]),
            ),
          ],
        ),
      ),
      body: SignUpBody(),
    );
  }
}
