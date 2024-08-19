
import 'package:all_of_football/api/domain/api_result.dart';
import 'package:all_of_football/api/domain/result_code.dart';
import 'package:all_of_football/api/service/token_service.dart';
import 'package:all_of_football/api/service/user_service.dart';
import 'package:all_of_football/api/social/line_api.dart';
import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:all_of_football/domain/user/social_result.dart';
import 'package:all_of_football/domain/user/user_profile.dart';
import 'package:all_of_football/widgets/pages/poppages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class UserNotifier extends StateNotifier<UserProfile?> {
  UserNotifier() : super(null);

  void setProfile(UserProfile newProfile) {
    state = newProfile;
  }

  Future<ResponseResult> login(BuildContext context) async {
    final socialResult = await LineAPI.login();
    if (socialResult == null) {
      state = null;
      return ResponseResult(ResultCode.SOCIAL_LOGIN_FAILD, null);
    }
    final result = await UserService.login(socialResult);
    if (result == ResultCode.REGISTER) {
      return ResponseResult(result, socialResult);
    }
    readUser();
    return ResponseResult(result, null);
  }

  Future<bool> register({required SexType sex, required DateTime birth, required SocialResult social}) async {
    final response = await UserService.register(
      sex: sex,
      birth: birth,
      social: social,
    );
    if (response == ResultCode.OK) {
      readUser();
      return true;
    }
    return false;
  }

  void logout() async {
    LineAPI.logout();
    state = null;
  }

  bool has() {
    return state != null;
  }

  readUser() async {
    final result = await TokenService.readUser();
    if (result) {
      state = await UserService.getProfile();
    } else {
      logout();
    }
  }


  int? getId() {
    return state?.id;
  }

  Image? getImage() {
    return state?.image;
  }

  String? getName() {
    return state?.nickname;
  }

  SexType? getSex() {
    return state?.sex;
  }

  DateTime? getBirth() {
    return state?.birth;
  }

}

final loginProvider = StateNotifierProvider<UserNotifier, UserProfile?>((ref) => UserNotifier(),);