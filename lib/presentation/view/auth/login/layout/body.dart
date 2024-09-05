import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:news_app/infrastructure/models/login.dart';
import 'package:news_app/infrastructure/models/user.dart';
import 'package:news_app/infrastructure/services/user.dart';
import 'package:news_app/presentation/elements/app_loader.dart';
import 'package:news_app/presentation/view/category/all_categories.dart';
import 'package:news_app/presentation/view/news/news_view.dart';
import 'package:news_app/presentation/view/user_profile/update_profile_view.dart';
import 'package:news_app/presentation/view/user_profile/user_profile_view.dart';
import 'package:provider/provider.dart';

import '../../../../../applications/provider.dart';
import '../../../../../configurations/frontend_configs.dart';
import '../../../../../infrastructure/services/auth.dart';
import '../../../../elements/app_button.dart';
import '../../../../elements/custom_text.dart';
import '../../../../elements/custom_textfield.dart';
import '../../../../elements/flash_bar.dart';

class LogInBody extends StatefulWidget {
  const LogInBody({super.key});

  @override
  State<LogInBody> createState() => _LogInBodyState();
}

class _LogInBodyState extends State<LogInBody> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator:const LoadingWidget(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    CustomText(
                      text: "Login",
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 38,
                    ),
                    CustomTextField(
                      hintText: "username@gmail.com",
                      keyBoardType: TextInputType.emailAddress,
                      controller: _emailController,
                      title: "Email",
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomTextField(
                      hintText: "Password",
                      keyBoardType: TextInputType.text,
                      controller: _passwordController,
                      isPassword: true,
                      isSecure: true,
                      title: "Password",
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: "Forgot Password?",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: FrontendConfigs.kAppGreyColor),
                              children: [
                                TextSpan(
                                  text: " Reset",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: FrontendConfigs.kAppPrimaryColor),
                                )
                              ]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    AppButton(
                        onPressed: () async {
                          if (_emailController.text.isEmpty) {
                            getFlushBar(context, title: "Email cannot be empty.");
                            return;
                          }
                          if (_passwordController.text.isEmpty) {
                            getFlushBar(context,
                                title: "Password cannot be empty.");
                            return;
                          }
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await AuthServices()
                                .loginUser(
                              email: _emailController.text,
                              password: _passwordController.text,
                            )
                                .then((user) async {
                                     await UserService()
                                        .fetchUserProfile(token: user.token.toString())
                                        .then((val)  {
                                      Provider.of<UserProvider>(context,
                                          listen: false)
                                          .saveUserDate(val,user.token.toString());
                                    });
                                  });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                         CategoriesView()));
                          } catch (e) {
                            getFlushBar(context, title: e.toString());
                          } finally {
                            setState(() {
                              isLoading = false; // Hide loader
                            });
                          }
                        },
                        btnLabel: "Login"),
                  ],
                ),
        ),
      ),
    );
  }
}
