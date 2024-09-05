class CommentModel {
  final String id;
  final String userId;
  final String newsPostId;
  final String content;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.userId,
    required this.newsPostId,
    required this.content,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      userId: json['userId'],
      newsPostId: json['newsPostId'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'newsPostId': newsPostId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
