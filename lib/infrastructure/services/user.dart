import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class UserService {
  Future<UserModel> fetchUserProfile({required String token}) async {
    final response = await http.get(
      Uri.parse("https://news-api-task2.vercel.app/users/profile"),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode==201) {
      final data = jsonDecode(response.body);
      UserModel userModel = UserModel.fromJson(data);
      return userModel;
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
