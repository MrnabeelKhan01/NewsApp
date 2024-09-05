import 'package:flutter/material.dart';
import 'package:news_app/presentation/elements/custom_appbar.dart';
import 'package:news_app/presentation/elements/custom_text.dart';
import 'package:news_app/presentation/view/user_profile/layout/body.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:customAppBar(context,title:"Profile",isShowTitle:true),
      body: UserProfileBody(),
    );
  }
}
