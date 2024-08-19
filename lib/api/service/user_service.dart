
import 'dart:convert';

import 'package:all_of_football/api/api_service.dart';
import 'package:all_of_football/api/domain/result_code.dart';
import 'package:all_of_football/component/secure_strage.dart';
import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:all_of_football/domain/user/social_result.dart';
import 'package:all_of_football/domain/user/user_profile.dart';
import 'package:intl/intl.dart';

class UserService {

  static Future<ResultCode> login(SocialResult result) async {
    final response = await ApiService.post(
      uri: '/social/login',
      authorization: false,
      header: ApiService.contentTypeJson,
      body: jsonEncode({
        "socialId" : result.socialId,
        "provider" : result.provider.name,
        "accessToken" : result.accessToken
      }),
    );

    if (response.resultCode == ResultCode.OK) {
      await SecureStorage.saveAccessToken(response.data['accessToken']);
      await SecureStorage.saveRefreshToken(response.data['refreshToken']);
      print('LINE LOGIN SUCCESS !!!');
    }
    return response.resultCode;
  }

  static Future<UserProfile?> getProfile() async {

    final response = await ApiService.get(
      uri: '/user/profile',
      authorization: true,
    );

    if (response.resultCode == ResultCode.OK) {
      return UserProfile.fromJson(response.data);
    }
    return null;
  }

  static Future<ResultCode> register({required SexType sex, required DateTime birth, required SocialResult social}) async {

    final response = await ApiService.post(
        uri: '/register',
        authorization: false,
        header: ApiService.contentTypeJson,
        body: jsonEncode({
          "sex" : sex.name,
          "birth" : DateFormat('yyyy-MM-dd').format(birth),
          "socialId" : social.socialId,
          "provider" : social.provider.name,
          "accessToken" : social.accessToken
        })
    );

    if (response.resultCode == ResultCode.OK) {
      await SecureStorage.saveAccessToken(response.data['accessToken']);
      await SecureStorage.saveRefreshToken(response.data['refreshToken']);
      print('REGISTER SUCCESS !!!');
    }
    return response.resultCode;
  }

}