
import 'package:all_of_football/api/api_service.dart';
import 'package:all_of_football/api/domain/api_result.dart';
import 'package:all_of_football/domain/enums/payment.dart';

class PaymentService {

  static Future<ResponseResult> readyPayment({required int amount, required Payment payment}) async {
    return await ApiService.get(
        uri: '/user/cash/charge/${payment.url}?amount=$amount',
        authorization: true
    );
  }

}