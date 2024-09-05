import 'package:flutter/cupertino.dart';

import '../infrastructure/models/user.dart';

class UserProvider extends ChangeNotifier {
  UserModel _model = UserModel();
  String ? _token;

  void saveUserDate(UserModel userModel, String token) {
    _model = userModel;
    _token=token;
    notifyListeners();
  }

  UserModel get getUserData => _model;
  String? get getToken =>_token;
}
