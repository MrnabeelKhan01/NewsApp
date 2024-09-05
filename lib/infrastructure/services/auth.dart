import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/infrastructure/models/login.dart';
import 'package:news_app/infrastructure/models/sign_up.dart';
import 'package:news_app/infrastructure/models/user.dart';
import 'package:news_app/presentation/view/auth/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/error.dart';

class AuthServices {
  final String _baseUrl = "https://news-api-task2.vercel.app";

  Future<RegistrationModel> registerUser(
      {required String email,
      required String name,
      required String profilePicture,
      required String password}) async {
    final url = Uri.parse("$_baseUrl/users/register");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        "email": email,
        "name": name,
        "password": password,
        "profilePicture": profilePicture
      }),
    );
    log(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegistrationModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception('Failed to load data');
    } else {
      throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  // Future<Either<ErrorModel, LoginModel>> loginUser({
  //   required String email,
  //   required String password,
  // }) async {
  //   final url = Uri.parse("$_baseUrl/users/login");
  //
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //     },
  //     body: json.encode({
  //       "email": email,
  //       "password": password,
  //     }),
  //   );
  //   log(response.request!.url.toString());
  //   log(response.reasonPhrase.toString());
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return Right(LoginModel.fromJson(jsonDecode(response.body)));
  //   } else if (response.statusCode == 400) {
  //     return Left(
  //         ErrorModel(success: false, message: "Email or Password is invalid."));
  //   } else if (response.statusCode == 401) {
  //     return Left(ErrorModel(
  //         success: false,
  //         message: "Sorry! You are not allowed to perform this operation"));
  //   } else if (response.statusCode == 404) {
  //     return Left(ErrorModel(
  //         success: false,
  //         message: "Sorry! Your requested data does not exist."));
  //   } else if (response.statusCode == 500) {
  //     return Left(ErrorModel(
  //         success: false,
  //         message: "Sorry! We are unable to connect our servers."));
  //   } else {
  //     return Left(ErrorModel(
  //         success: false,
  //         message: "Sorry! Something went wrong. Please try again later."));
  //   }
  // }
  Future<LoginModel> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$_baseUrl/users/login");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        "email": email,
        "password": password,
      }),
    );
    log(response.request!.url.toString());
    log(response.reasonPhrase.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      return LoginModel();
    }
  }

  Future<bool> logout({required String token}) async {
    final url = Uri.parse('$_baseUrl/users/logout');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      await _clearUserData();
      return true;
    } else {
      print("Logout failed: ${response.body}");
      return false;
    }
  }

  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<UserModel> updateUserProfile({
    required String name,
    required String token,
  }) async {
    final url = Uri.parse("https://news-api-task2.vercel.app/users/updateprofile");

    try {
      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': '$token',
        },
        body: jsonEncode({
          'name': name,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return UserModel(
          id: data['_id'],
          name: data['name'],
          email: data['email'],
          profilePicture: data['profilePicture'] ?? '',
        );
      } else {
        log('Error: ${response.reasonPhrase}');
        throw Exception('Failed to update profile: ${response.body}');
      }
    } catch (e) {
      log('Exception: $e');
      throw Exception('Failed to update profile: $e');
    }
  }

  // Future<void> deleteUserProfile(String userId, String token) async {
  //   final String url = 'https://news-api-task2.vercel.app/users/profile/$userId';
  //
  //   try {
  //     final response = await http.delete(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': '$token', // Add token for authorization if required
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // Successfully deleted the profile
  //       print("User profile deleted successfully.");
  //     } else {
  //       // Error occurred during deletion
  //       print("Failed to delete user profile. Status code: ${response.statusCode}");
  //       print("Response body: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

}
