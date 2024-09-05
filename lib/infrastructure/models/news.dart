// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) => List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  String? id;
  String? title;
  String? content;
  Category? category;
  Author? author;
  List<String>? likes;
  List<String>? dislikes;
  List<String>? favorites;
  dynamic image;
  int? shares;
  List<Comment>? comments;
  List<Report>? reports;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  NewsModel({
    this.id,
    this.title,
    this.content,
    this.category,
    this.author,
    this.likes,
    this.dislikes,
    this.favorites,
    this.image,
    this.shares,
    this.comments,
    this.reports,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    id: json["_id"],
    title: json["title"],
    content: json["content"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    likes: json["likes"] == null ? [] : List<String>.from(json["likes"]!.map((x) => x)),
    dislikes: json["dislikes"] == null ? [] : List<String>.from(json["dislikes"]!.map((x) => x)),
    favorites: json["favorites"] == null ? [] : List<String>.from(json["favorites"]!.map((x) => x)),
    image: json["image"],
    shares: json["shares"],
    comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
    reports: json["reports"] == null ? [] : List<Report>.from(json["reports"]!.map((x) => Report.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "content": content,
    "category": category?.toJson(),
    "author": author?.toJson(),
    "likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x)),
    "dislikes": dislikes == null ? [] : List<dynamic>.from(dislikes!.map((x) => x)),
    "favorites": favorites == null ? [] : List<dynamic>.from(favorites!.map((x) => x)),
    "image": image,
    "shares": shares,
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
    "reports": reports == null ? [] : List<dynamic>.from(reports!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Author {
  Id? id;
  Name? name;

  Author({
    this.id,
    this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: idValues.map[json["_id"]]!,
    name: nameValues.map[json["name"]]!,
  );

  Map<String, dynamic> toJson() => {
    "_id": idValues.reverse[id],
    "name": nameValues.reverse[name],
  };
}

enum Id {
  THE_66_AC88_F17_E9_FF201768_EA28_E
}

final idValues = EnumValues({
  "66ac88f17e9ff201768ea28e": Id.THE_66_AC88_F17_E9_FF201768_EA28_E
});

enum Name {
  ADMIN
}

final nameValues = EnumValues({
  "admin": Name.ADMIN
});

class Category {
  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Comment {
  String? user;
  String? content;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  Comment({
    this.user,
    this.content,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    user: json["user"],
    content: json["content"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "content": content,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Report {
  String? reportedBy;
  String? reason;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  Report({
    this.reportedBy,
    this.reason,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    reportedBy: json["reportedBy"],
    reason: json["reason"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "reportedBy": reportedBy,
    "reason": reason,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
