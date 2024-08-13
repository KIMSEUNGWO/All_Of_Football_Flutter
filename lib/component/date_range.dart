
import 'package:all_of_football/component/calendar_date_helper.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/src/widgets/page_view.dart';

class MonthRange {

  final int min;
  final int max;

  MonthRange({DateTime? min, DateTime? max}):
    min = CalendarDateTimeHelper.monthCount(min ?? DateTime(1900, 1, 1)),
    max = CalendarDateTimeHelper.monthCount(max ?? DateTime(2999, 12, 1));
}

class CalendarController {

  final PageController pageController;
  final MonthRange range;

  bool prevDisabled = false;
  bool nextDisabled = false;

  final Duration _duration = const Duration(milliseconds: 500);
  final Cubic curves = Curves.easeInOut;

  CalendarController({required this.range, required this.pageController});

  void pageChange(int page) {
    prevDisabled = range.min >= page;
    nextDisabled = range.max <= page;
  }

  bool hasRange(DateTime date) {
    int monthCount = CalendarDateTimeHelper.monthCount(date);
    return !(range.min > monthCount || range.max < monthCount);
  }

  void previousPage() {
    if (prevDisabled) return;
    pageController.previousPage(duration: _duration, curve: curves);
  }
  void nextPage() {
    if (nextDisabled) return;
    pageController.nextPage(duration: _duration, curve: curves);
  }
}