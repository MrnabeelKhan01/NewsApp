// import 'dart:convert';
// import 'package:http/http.dart'as http;
// import 'package:news_app/infrastructure/models/comments.dart';
//
// class PostServices{
//   Future<CommentModel> postComments({required String token,required String newPostId}) async {
//     final response = await http.post(
//       Uri.parse("https://news-api-task2.vercel.app/news/newspost/668ce049c144e41ccd768bcb/comment"),
//       headers: {
//         'Authorization': token,
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'content': content,
//       }),
//     );
//
//
//     if (response.statusCode == 200 || response.statusCode==201) {
//       final data = jsonDecode(response.body);
//       CommentModel commentModel = CommentModel.fromJson(data);
//       return commentModel;
//     } else {
//       throw Exception('Failed to load user profile');
//     }
//   }
// }