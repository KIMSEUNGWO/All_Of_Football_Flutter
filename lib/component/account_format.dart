
import 'package:intl/intl.dart';

class AccountFormatter {

  static String format(int amount, {bool showSign = false}) {
    final formatter = NumberFormat.decimalPattern('ko_KR');
    String result = '${formatter.format(amount)}원';
    if (showSign && amount > 0) result = '+$result';
    return result;
  }
}