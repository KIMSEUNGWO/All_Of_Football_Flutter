

import 'package:all_of_football/api/api_service.dart';
import 'package:all_of_football/api/domain/api_result.dart';

class FieldService {
  static Future<ResponseResult> getField({required int fieldId}) async {
    return await ApiService.get(
        uri: '/field/$fieldId',
        authorization: true
    );
  }

}