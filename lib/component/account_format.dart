
import 'package:intl/intl.dart';

class AccountFormatter {

  static String format(int amount) {
    final formatter = NumberFormat.decimalPattern('ko_KR');
    return '${formatter.format(amount)}원';
  }
}