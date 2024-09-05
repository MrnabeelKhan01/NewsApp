import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../configurations/frontend_configs.dart';
import '../sign_up/sign_up_view.dart';
import 'layout/body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                  text: "Don’t have an account?",
                  style: const TextStyle(
                      fontFamily: "EncodeSansSemiCondensed",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff4B5563)),
                  children: [
                    TextSpan(
                      text: " Signup",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpView()));
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
      body:  LogInBody(),
    );
  }
}
