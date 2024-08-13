
import 'package:all_of_football/component/calendar_date_helper.dart';
import 'package:all_of_football/component/date_range.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderWidget extends StatefulWidget {
  final Function(DateTime date) onChanged;
  final MonthRange? monthRange;

  const CalenderWidget({super.key, this.monthRange, required this.onChanged});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {

  late PageController _pageController;
  late DateTime _today;
  late DateTime _selectDate;
  late DateTime _currentMonth;
  final CalendarDateTimeHelper calendarHelper = CalendarDateTimeHelper();
  late int _previousPage;

  // void _preDate() {
  //   // DateTime safeDateTime = calendarHelper.safeMoveDate(_selectDate, DateTime(_currentMonth.year, _currentMonth.month - 1));
  //   // _select(safeDateTime);
  // }
  // void _nextDate() {
  //   // DateTime safeDateTime = calendarHelper.safeMoveDate(_selectDate, DateTime(_currentMonth.year, _currentMonth.month + 1));
  //   // _select(safeDateTime);
  // }

  void _preDate() {
    _pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
  }
  void _nextDate() {
    _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
  }

  void _select(DateTime date) {
    if (_selectDate.compareTo(date) == 0) return;
    setState(() {
      _selectDate = date;
      _currentMonth = DateTime(_selectDate.year, _selectDate.month);
    });
    widget.onChanged(date);
  }

  void _onPageChanged(int page) {
    if (_previousPage < page) {
      setState(() {
        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
      });
    } else if (_previousPage > page) {
      setState(() {
        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
      });
    }

    setState(() {
      _previousPage = page;
    });
  }

  DateTime _onChange(int page) {
    if (_previousPage < page) {
      return DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    } else if (_previousPage > page) {
      return DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    }
    return _currentMonth;
  }

  @override
  void initState() {
    DateTime now = DateTime.now();
    _today = DateTime(now.year, now.month, now.day);
    _currentMonth = DateTime(now.year, now.month, 1);
    _selectDate = DateTime(now.year, now.month, now.day);
    _pageController = PageController(
      initialPage: widget.monthRange?.min == null
        ? calendarHelper.monthCount(now) - calendarHelper.monthCount(DateTime(1900, 1, 1))
        : widget.monthRange!.min!,
      keepPage: true,
    );
    _previousPage = _pageController.initialPage;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(DateFormat('yyyy년 MM월').format(_currentMonth),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                  fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(width: 15,),
              Row(
                children: [
                  GestureDetector(
                    onTap: _preDate,
                    child: Icon(Icons.arrow_back_ios_new_rounded,
                      size: 15,
                      color: Color(0xFF292929),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  GestureDetector(
                    onTap: _nextDate,
                    child: Icon(Icons.arrow_forward_ios_rounded,
                      size: 15,
                      // color: Color(0xFF999999),
                      color: Color(0xFF292929),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15,),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: calendarHelper.calculateHeight(context)
            ),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return _Calendar(
                  currentMonth: _onChange(index),
                  today: _today,
                  selectDate: _selectDate,
                  select: _select
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Calendar extends StatefulWidget {

  final DateTime today;
  final DateTime currentMonth;
  final DateTime selectDate;
  final Function(DateTime date) select;

  const _Calendar({required this.today, required this.currentMonth, required this.selectDate, required this.select});

  @override
  State<_Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<_Calendar> with AutomaticKeepAliveClientMixin {
  final List<String> _weeks = ['일', '월', '화', '수', '목', '금', '토'];
  final CalendarDateTimeHelper calendarHelper = CalendarDateTimeHelper();

  @override
  void initState() {
    print('_CalendarState.initState');
    super.initState();
  }
  @override
  void dispose() {
    print('_CalendarState.dispose');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<DateTime> calendar = calendarHelper.generate(widget.currentMonth);
    return Column(
      children: [
        GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 한 줄에 7개의 항목(요일 수)
          ),
          itemCount: 7,
          itemBuilder: (context, index) {
            return Center(
              child: Text(_weeks[index],
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                    fontWeight: FontWeight.w600
                ),
              ),
            );
          },
        ),
        GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 한 줄에 7개의 항목(요일 수)
          ),
          itemCount: calendar.length,
          itemBuilder: (context, index) {

            DateTime date = calendar[index];
            bool isToday = widget.today.compareTo(date) == 0;
            bool isSelectDay = widget.selectDate.compareTo(date) == 0;

            return GestureDetector(
              onTap: () {
                widget.select(date);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: isSelectDay
                        ? Theme.of(context).colorScheme.onPrimary
                        : null
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${date.day}',
                        style: TextStyle(
                            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                            fontWeight: FontWeight.w600,
                            color: (widget.currentMonth.year != date.year || widget.currentMonth.month != date.month) ? const Color(0xFF797979)
                                : isSelectDay ? Colors.white
                                : date.weekday == 7 ? const Color(0xFFE30000)
                                : const Color(0xFF292929)
                        ),
                      ),
                      if (isToday)
                        Text('Today',
                          style: TextStyle(
                              fontStyle: Theme.of(context).textTheme.bodySmall!.fontStyle,
                              color: isSelectDay ? Colors.white
                                  : null
                          ),
                        )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}


