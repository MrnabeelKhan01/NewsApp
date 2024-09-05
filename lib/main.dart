import 'package:flutter/material.dart';
import 'package:news_app/presentation/view/auth/login/login_view.dart';
import 'package:news_app/presentation/view/auth/sign_up/sign_up_view.dart';
import 'package:news_app/presentation/view/bottom_bar/custom_bottom.dart';
import 'package:news_app/presentation/view/category/all_categories.dart';
import 'package:news_app/presentation/view/user_profile/update_profile_view.dart';
import 'package:news_app/presentation/view/user_profile/user_profile_view.dart';
import 'package:provider/provider.dart';

import 'applications/provider.dart';
import 'presentation/view/news/news_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider())
        ],
        child: MaterialApp(
          theme: ThemeData(
              fontFamily: "Poppins",
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white),
          home:  const LoginView(),
        ));
  }
}
