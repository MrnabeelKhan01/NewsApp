import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'exceptions.dart';

class BaseApiHelper {
  Future<dynamic> get({required String endPoint}) async {
    var responseJson;
    try {
      final response =
      await http.get(Uri.parse("https://news-api-task2.vercel.app/$endPoint"));
      log(response.body.toString());
      responseJson = _returnResponse(response);
    } on SocketException catch (e) {
      throw FetchDataException("No internet connection");
    } catch (e) {
      log(e.toString());
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        return responseJson;

      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
