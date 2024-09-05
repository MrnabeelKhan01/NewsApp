import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:news_app/applications/api_helper.dart';
import 'package:news_app/infrastructure/models/category.dart';
import 'package:news_app/infrastructure/models/news.dart';

BaseApiHelper _apiHelper = BaseApiHelper();

class GetServices {
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _apiHelper.get(
        endPoint: 'categories/getcategories',
      );
      return (response as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  Future<List<NewsModel>> getAllNews({required String categoryId}) async {
    try {
      final response = await _apiHelper.get(
        endPoint: 'news/getnews',
      );
      return (response as List)
          .map((item) => NewsModel.fromJson(item))
          .toList();
    } catch (e) {
       log(e.toString());
      rethrow;
    }
  }
}
