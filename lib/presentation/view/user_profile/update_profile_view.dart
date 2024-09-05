import 'package:flutter/material.dart';
import 'package:news_app/infrastructure/services/auth.dart';
import 'package:news_app/presentation/elements/app_button.dart';
import 'package:news_app/presentation/elements/app_loader.dart';
import 'package:news_app/presentation/elements/custom_appbar.dart';
import 'package:news_app/presentation/elements/custom_textfield.dart';
import 'package:news_app/presentation/elements/flash_bar.dart';
import 'package:provider/provider.dart';
import '../../../applications/provider.dart';

class UpdateProfileView extends StatefulWidget {
  @override
  _UpdateProfileViewState createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    _nameController.text = userProvider.getUserData.name.toString();
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserProvider>(context);
    var getToken = userData.getToken.toString();

    return Scaffold(
      appBar: customAppBar(context,isShowTitle:true,title:"Update Profile"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:isLoading?const LoadingWidget(): Column(
          children: [
            CustomTextField(
              hintText: "Name",
              keyBoardType: TextInputType.text,
              title: "Name",
              controller: _nameController,
            ),
            const SizedBox(height: 20),
               AppButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        var updatedUserData =
                            await AuthServices().updateUserProfile(
                          name: _nameController.text,
                          token: getToken,
                        );
                        userData.saveUserDate(updatedUserData, getToken);
                        Navigator.pop(context);
                        return;
                        getFlushBar(
                          context,
                          title: "Success",
                        );
                      } catch (error) {
                        getFlushBar(
                          context,
                          title: "Error",
                        );
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    btnLabel: 'Update',
                  ),
          ],
        ),
      ),
    );
  }
}
