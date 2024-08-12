
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {

  late PageController _pageController;
  late DateTime _today;
  late DateTime _selectDate;
  late DateTime _currentDate;

  final List<String> _weeks = ['일', '월', '화', '수', '목', '금', '토'];

  void _preDate() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1, 1);
    });
  }
  void _nextDate() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, 1);
    });
  }
  void _select(DateTime date) {
    int cYear = _selectDate.year;
    int cMonth = _selectDate.month;
    int sYear = date.year;
    int sMonth = date.month;

    if (cYear > sYear || (cYear == sYear && cMonth > sMonth)) {
      _preDate(); // 이전 달로 이동
    } else if (cYear < sYear || (cYear == sYear && cMonth < sMonth)) {
      _nextDate(); // 다음 달로 이동
    }

    setState(() {
      _selectDate = date;
    });
  }

  List<DateTime> generate(DateTime date) {
    List<DateTime> result = [];

    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);


    int startWeekday = firstDayOfMonth.weekday % 7; // 1: 월요일, 7: 일요일
    // 이전 달의 마지막 날짜들 추가
    if (startWeekday > 0) {
      for (int i = startWeekday; i > 0; i--) {
        result.add(firstDayOfMonth.add(Duration(days: -1 * i)));
      }
    }

    int daysInMonth = DateTime(date.year, date.month, 0).day; // 해당 월의 일수
    for (int i=0;i<daysInMonth;i++) {
      result.add(firstDayOfMonth.add(Duration(days: i)));
    }

    // 다음 달의 첫 날짜들 추가
    int remainingDays = 7 - result.length % 7;
    if (remainingDays < 7) {
      for (int i = 1; i <= remainingDays; i++) {
        result.add(firstDayOfMonth.add(Duration(days: daysInMonth + i - 1)));
      }
    }

    return result;

  }

  @override
  void initState() {
    DateTime now = DateTime.now();
    _today = DateTime(now.year, now.month, now.day);
    _currentDate = DateTime(now.year, now.month, 1);
    _selectDate = DateTime(now.year, now.month, now.day);
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    List<DateTime> calendar = generate(_currentDate);

    return CustomContainer(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(DateFormat('yyyy년 M월').format(_currentDate),
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
                  SizedBox(width: 15,),
                  GestureDetector(
                    onTap: _nextDate,
                    child: Icon(Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15,),
          Column(
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
                  bool isToday = _today.compareTo(date) == 0;
                  bool isSelectDay = _selectDate.compareTo(date) == 0;

                  return GestureDetector(
                    onTap: () {
                      _select(date);
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
                                  color: (_currentDate.year != date.year || _currentDate.month != date.month) ? const Color(0xFF797979)
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
          ),
        ],
      ),
    );
  }
}

