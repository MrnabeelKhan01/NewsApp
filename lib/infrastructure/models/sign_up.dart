// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromJson(jsonString);

import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) => RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());

class RegistrationModel {
  User? user;
  String? message;

  RegistrationModel({
    this.user,
    this.message,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "message": message,
  };
}

class User {
  String? name;
  String? email;
  String? password;
  String? profilePicture;
  String? id;
  int? v;

  User({
    this.name,
    this.email,
    this.password,
    this.profilePicture,
    this.id,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    profilePicture: json["profilePicture"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "profilePicture": profilePicture,
    "_id": id,
    "__v": v,
  };
}
