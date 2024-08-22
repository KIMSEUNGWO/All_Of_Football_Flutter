
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:all_of_football/api/domain/api_result.dart';
import 'package:all_of_football/api/utils/header_helper.dart';
import 'package:all_of_football/component/alert.dart';
import 'package:all_of_football/exception/server/server_exception.dart';
import 'package:all_of_football/exception/server/socket_exception.dart';
import 'package:all_of_football/exception/server/timeout_exception.dart';
import 'package:all_of_football/exception/socket_exception_os_code.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static const String server = "http://localhost:8080";
  static const Duration _delay = Duration(seconds: 1);
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

    final response = await _execute(http.post(Uri.parse('$server$uri'), headers: requestHeader, body: body));
    return _decode(response);
  }

  static Future<ResponseResult> get({required String uri, required bool authorization, Map<String, String>? header}) async {

    Map<String, String> requestHeader = {"Content-Type" : "application/json; charset=utf-8",};
    await getHeaders(requestHeader, authorization, header);

    final response = await _execute(http.get(Uri.parse('$server$uri'), headers: requestHeader));
    return _decode(response);
  }

  static Future<T> _execute<T> (Future<T> method) async {
    try {
      return await method.timeout(_delay);
    } on TimeoutException catch (_) {
      throw TimeOutException("서버 응답이 지연되고 있습니다. 나중에 다시 시도해주세요.");
    } on SocketException catch (_) {
      print(_);
      SocketOSCode error = SocketOSCode.convert(_.osError?.errorCode);
      throw InternalSocketException(error);
    } catch (e) {
      print(e);
      throw ServerException("정보를 불러오는데 실패했습니다");
    }
  }


}