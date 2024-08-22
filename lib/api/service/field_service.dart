

import 'package:all_of_football/api/api_service.dart';
import 'package:all_of_football/api/domain/api_result.dart';
import 'package:all_of_football/api/domain/result_code.dart';
import 'package:all_of_football/component/pageable.dart';
import 'package:all_of_football/domain/match/match_simp.dart';

class FieldService {
  static Future<ResponseResult> getField({required int fieldId}) async {
    return await ApiService.get(
        uri: '/field/$fieldId',
        authorization: true
    );
  }

  static Future<List<MatchSimp>> getSchedule(int fieldId, Pageable pageable) async {
    final response = await ApiService.get(
        uri: '/field/$fieldId/schedule?page=${pageable.page}&size=${pageable.size}',
        authorization: false
    );

    if (response.resultCode == ResultCode.OK) {
      return List<MatchSimp>.from(response.data.map((x) => MatchSimp.fromJson(x)));
    } else {
      return [];
    }
  }

}