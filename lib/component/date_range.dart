
import 'package:all_of_football/component/calendar_date_helper.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/src/widgets/page_view.dart';

class CalendarController {

  final PageController pageController;
  final MonthRange range;

  bool prevDisabled = false;
  bool nextDisabled = false;

  final Duration _duration = const Duration(milliseconds: 500);
  final Cubic curves = Curves.easeInOut;

  CalendarController({required this.range}):
    pageController = PageController(
      initialPage: range.initPage,
      keepPage: true,
    );


  void pageChange(int page) {
    prevDisabled = 0 >= page;
    nextDisabled = range.maxPage - 1 <= page;
  }

  bool hasRange(DateTime date) {
    int monthCount = DateTimeHelper.monthCount(date);
    return !(DateTimeHelper.monthCount(range.min) > monthCount || DateTimeHelper.monthCount(range.max) < monthCount);
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

class MonthRange {

  final DateTime min;
  final DateTime max;
  final int initPage;
  final int maxPage;

  MonthRange({DateTime? min, DateTime? max}):
    min = min ?? DateTime(1900, 1, 1),
    max = max ?? DateTime(2999, 12, 1),
    initPage = DateTimeHelper.monthCount(DateTime.now()) - DateTimeHelper.monthCount(min ?? DateTime(1900, 1, 1)),
    maxPage = DateTimeHelper.monthCount(DateTime.now()) - DateTimeHelper.monthCount(min ?? DateTime(1900, 1, 1))
        + DateTimeHelper.monthCount(max ?? DateTime(2999, 12, 1)) - DateTimeHelper.monthCount(DateTime.now())
        + 1;


}
