
import 'package:all_of_football/component/date_range.dart';
import 'package:all_of_football/component/region_data.dart';
import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:all_of_football/domain/match/match_search_view.dart';
import 'package:all_of_football/widgets/component/calender.dart';
import 'package:all_of_football/widgets/component/match_list.dart';
import 'package:flutter/material.dart';

import 'package:skeletonizer/skeletonizer.dart';

class MatchHistoryWidget extends StatefulWidget {
  const MatchHistoryWidget({super.key});

  @override
  State<MatchHistoryWidget> createState() => _MatchHistoryWidgetState();
}

class _MatchHistoryWidgetState extends State<MatchHistoryWidget> {

  bool _loading = true;
  final Map<DateTime, List<MatchView>> map = {};
  late List<MatchView> _items = [];

  void _fetchData(DateTime date) {
    List<MatchView> result = [
      MatchView(1, MatchStatus.OPEN, '안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(null, Region.BUNKYO, 5, 3)),
      MatchView(2, MatchStatus.CLOSING_SOON, '안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(SexType.MALE, Region.BUNKYO, 5, 2)),
      MatchView(3, MatchStatus.CLOSED, '안양대학교 SKY 풋살파크 C구장안양대학교 SKY 풋살파크 C구장안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(SexType.FEMALE, Region.BUNKYO, 6, 3)),
      MatchView(4, MatchStatus.FINISHED, '어딘가의 구장', DateTime(2024, 01, 1, 1,1), MatchData(null, Region.BUNKYO, 6, 2)),
      MatchView(1, MatchStatus.OPEN, '안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(null, Region.BUNKYO, 5, 3)),
      MatchView(2, MatchStatus.CLOSING_SOON, '안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(SexType.MALE, Region.BUNKYO, 5, 2)),
      MatchView(3, MatchStatus.CLOSED, '안양대학교 SKY 풋살파크 C구장안양대학교 SKY 풋살파크 C구장안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(SexType.FEMALE, Region.BUNKYO, 6, 3)),
      MatchView(4, MatchStatus.FINISHED, '어딘가의 구장', DateTime(2024, 01, 1, 1,1), MatchData(null, Region.BUNKYO, 6, 2)),
      MatchView(1, MatchStatus.OPEN, '안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(null, Region.BUNKYO, 5, 3)),
      MatchView(2, MatchStatus.CLOSING_SOON, '안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(SexType.MALE, Region.BUNKYO, 5, 2)),
      MatchView(3, MatchStatus.CLOSED, '안양대학교 SKY 풋살파크 C구장안양대학교 SKY 풋살파크 C구장안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(SexType.FEMALE, Region.BUNKYO, 6, 3)),
      MatchView(4, MatchStatus.FINISHED, '어딘가의 구장', DateTime(2024, 01, 1, 1,1), MatchData(null, Region.BUNKYO, 6, 2)),
      MatchView(1, MatchStatus.OPEN, '안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(null, Region.BUNKYO, 5, 3)),
      MatchView(2, MatchStatus.CLOSING_SOON, '안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(SexType.MALE, Region.BUNKYO, 5, 2)),
      MatchView(3, MatchStatus.CLOSED, '안양대학교 SKY 풋살파크 C구장안양대학교 SKY 풋살파크 C구장안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(SexType.FEMALE, Region.BUNKYO, 6, 3)),
      MatchView(4, MatchStatus.FINISHED, '어딘가의 구장', DateTime(2024, 01, 1, 1,1), MatchData(null, Region.BUNKYO, 6, 2)),

    ];
    if (DateTime(2024, 8, 13).compareTo(date) == 0) {
      map.putIfAbsent(date, () => result,);
    } else {
      map.putIfAbsent(date, () => [],);
    }
  }
  void _selectDate(DateTime selectDate) {
    setState(() {
      _items = [];
    });
    print('날짜 변경감지 : $selectDate');
    if (!map.containsKey(selectDate)) {
      print('데이터 없음');
      _fetchData(selectDate);
    }
    setState(() {
      _items = map[selectDate] ?? [];
      _loading = false;
    });
  }

  initSelectDate() {
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);
    _fetchData(currentDate);
    _items = map[currentDate]!;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    initSelectDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('경기내역'),
      ),
      body: Skeletonizer(
        enabled: _loading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                CalenderWidget(
                  onChanged: _selectDate,
                  monthRange: MonthRange(
                    min: DateTime(2024, 6),
                    max: DateTime(2024, 10),
                  ),
                ),
                const SizedBox(height: 16,),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16,);
                  },
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return MatchListWidget(match: _items[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
