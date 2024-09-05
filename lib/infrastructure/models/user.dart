
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String ?id;
  String ?name;
  String ?email;
  String ?profilePicture;

  UserModel({
     this.id,
     this.name,
     this.email,
     this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    profilePicture: json["profilePicture"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "profilePicture": profilePicture,
  };
}
