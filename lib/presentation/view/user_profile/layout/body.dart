import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/applications/provider.dart';
import 'package:news_app/infrastructure/services/auth.dart';
import 'package:news_app/presentation/elements/app_button.dart';
import 'package:news_app/presentation/elements/app_loader.dart';
import 'package:news_app/presentation/elements/custom_text.dart';
import 'package:news_app/presentation/elements/flash_bar.dart';
import 'package:news_app/presentation/view/auth/login/login_view.dart';
import 'package:provider/provider.dart';

import '../update_profile_view.dart';

class UserProfileBody extends StatelessWidget {
  UserProfileBody({super.key});

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserProvider>(context);
    return isLoading?LoadingWidget(): Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffD9D9D9),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  // child:Image.network(
                  //   userData.getUserData.profilePicture.toString(),
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          CustomText(
            text: userData.getUserData.name ?? 'No Name',
          ),
          const SizedBox(height: 6),
          CustomText(
            text: userData.getUserData.email ?? 'No Email',
          ),
          const SizedBox(height: 36),
          AppButton(
              onPressed: () async {
                if (userData.getToken != null) {
                  isLoading=true;
                  await AuthServices()
                      .logout(token: userData.getToken.toString())
                      .then((val) {
                    log(userData.getToken.toString());
                    getFlushBar(context,
                        title:
                            "${userData.getUserData.name}is successfully logout");
                    isLoading=false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()));
                  });
                } else {
                  getFlushBar(context,
                      title: "Logout failed please check the token");
                }
              },
              btnLabel: "Logout"),
          const SizedBox(height:18,),
          AppButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfileView()));
          }, btnLabel:"Update Profile")
        ],
      ),
    );
  }
}
