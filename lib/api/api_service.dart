
import 'dart:convert';

import 'package:all_of_football/api/domain/api_result.dart';
import 'package:all_of_football/api/utils/header_helper.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static const String server = "http://localhost:8080";
  static const Map<String, String> contentTypeJson = {
    "Content-Type" : "application/json; charset=utf-8",
  };

  static ResponseResult _decode(http.Response response) {
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    return ResponseResult.fromJson(json);
  }

  static getHeaders(Map<String, String> requestHeader, bool authorization, Map<String, String>? header) async {
    await HeaderHelper.getHeaders(requestHeader, authorization, header);
  }

  static Future<ResponseResult> post({required String uri, required bool authorization, Map<String, String>? header, Object? body,}) async {

    Map<String, String> requestHeader = {};
    await getHeaders(requestHeader, authorization, header);

    final response = await http.post(Uri.parse('$server$uri'), headers: requestHeader, body: body);
    return _decode(response);
  }

  static Future<ResponseResult> get({required String uri, required bool authorization, Map<String, String>? header}) async {
    Map<String, String> requestHeader = {"Content-Type" : "application/json; charset=utf-8",};
    await getHeaders(requestHeader, authorization, header);

    final response = await http.get(Uri.parse('$server$uri'), headers: requestHeader);
    return _decode(response);
  }

}