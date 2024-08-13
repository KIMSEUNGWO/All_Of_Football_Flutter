
import 'package:all_of_football/component/calendar_date_helper.dart';

class MonthRange {

  final int min;
  final int max;

  MonthRange({DateTime? min, DateTime? max}):
    min = CalendarDateTimeHelper.monthCount(min ?? DateTime(1900, 1, 1)),
    max = CalendarDateTimeHelper.monthCount(max ?? DateTime(2999, 12, 1));
}

class CalendarController {

  final MonthRange range;

  bool prevDisabled = false;
  bool nextDisabled = false;

  CalendarController({required this.range});

  void pageChange(int page) {
    prevDisabled = range.min >= page;
    nextDisabled = range.max <= page;
  }

  bool hasRange(DateTime date) {
    int monthCount = CalendarDateTimeHelper.monthCount(date);
    return !(range.min > monthCount || range.max < monthCount);
  }
}