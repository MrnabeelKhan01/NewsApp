import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/applications/app_state.dart';
import 'package:news_app/infrastructure/services/auth.dart';
import 'package:news_app/presentation/elements/app_loader.dart';
import 'package:news_app/presentation/view/auth/login/login_view.dart';
import '../../../../../configurations/frontend_configs.dart';
import '../../../../elements/app_button.dart';
import '../../../../elements/custom_text.dart';
import '../../../../elements/custom_textfield.dart';
import '../../../../elements/flash_bar.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return isLoading? const LoadingWidget():SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child:Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffD9D9D9)),
                        child: _image != null && _image!.path.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ))
                            : const SizedBox(),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            _pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: FrontendConfigs.kAppPrimaryColor),
                            child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              CustomTextField(
                hintText: "Full Name here",
                keyBoardType: TextInputType.name,
                controller: _nameController,
                title: "Full Name",
              ),
              const SizedBox(
                height: 18,
              ),
              CustomTextField(
                  hintText: "username@gmail.com",
                  keyBoardType: TextInputType.emailAddress,
                  controller: _emailController,
                  title: "Email"),
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
              CustomTextField(
                hintText: "Confirm Password",
                keyBoardType: TextInputType.text,
                controller: _confirmPasswordController,
                isPassword: true,
                isSecure: true,
                title: "Confirm Password",
              ),
              const SizedBox(
                height: 38,
              ),
              AppButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty) {
                      getFlushBar(context, title: "Full name cannot be empty.");
                      return;
                    }
                    if (_emailController.text.isEmpty) {
                      getFlushBar(context, title: "Email cannot be empty.");
                      return;
                    }
                    if (_passwordController.text.isEmpty) {
                      getFlushBar(context, title: "Password cannot be empty.");
                      return;
                    }
                    if (_confirmPasswordController.text.isEmpty) {
                      getFlushBar(context,
                          title: "Confirm Password cannot be empty.");
                      return;
                    }
                    if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      getFlushBar(context,
                          title: 'Confirm password does not match.');
                      return;
                    }
                    setState(() {
                      isLoading=true;
                    });
                    try {
                    await  AuthServices().registerUser(
                          email: _emailController.text,
                          name: _nameController.text,
                          password: _passwordController.text,
                          profilePicture: _image?.path??'').then((val){
                      log('Profile Picture Path: ${_image?.path}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginView()),
                        );
                      });
                    }catch(e){
                      getFlushBar(context, title: e.toString());
                    }finally {
                      setState(() {
                        isLoading = false; // Hide loader
                      });
                    }
                    print("Working");
                    },
                  btnLabel: "Signup"),
            ],
          ),
        ),
      ),
    );
  }
}
