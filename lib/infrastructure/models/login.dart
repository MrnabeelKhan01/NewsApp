// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  User? user;
  String? token;
  String? message;

  LoginModel({
    this.user,
    this.token,
    this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
    "message": message,
  };
}

class User {
  String? id;
  String? name;
  String? email;
  String? password;
  int? v;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "password": password,
    "__v": v,
  };
}
