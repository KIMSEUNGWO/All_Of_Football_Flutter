
import 'package:all_of_football/component/region_data.dart';
import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:all_of_football/domain/match/match_search_view.dart';
import 'package:all_of_football/domain/search_condition.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:all_of_football/widgets/component/custom_scroll_refresh.dart';
import 'package:all_of_football/widgets/component/match_extra_data.dart';
import 'package:all_of_football/widgets/component/search_data.dart';
import 'package:all_of_football/widgets/pages/poppages/match_detail_page.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class MatchListPageWidget extends StatefulWidget {
  const MatchListPageWidget({super.key});

  @override
  State<MatchListPageWidget> createState() => _MatchListPageWidgetState();
}

class _MatchListPageWidgetState extends State<MatchListPageWidget> with AutomaticKeepAliveClientMixin {

  final _dateRange = 14;
  int _currentDateIndex = 0;
  
  final List<MatchView> _items = [
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
  int _pageNumber = 0;
  final int _pageSize = 10;
  bool _hasMoreData = true;

  search(SearchCondition condition) {

  }
  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('도쿄구',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const Icon(Icons.keyboard_arrow_down_rounded)
          ]
        ),

      ),

      body: Column(
        children: [
          SearchData(search: search, dateRange: _dateRange, selectedDateIndex: _currentDateIndex),

          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  CustomScrollRefresh(onRefresh: () {
                  },),

                  const SliverPadding(padding: EdgeInsets.only(top: 32)),

                  SliverList.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16,);
                    },
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return _MatchListWidget(match: _items[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _MatchListWidget extends StatefulWidget {
  final MatchView match;
  const _MatchListWidget({super.key, required this.match,});

  @override
  State<_MatchListWidget> createState() => _MatchListWidgetState();
}

class _MatchListWidgetState extends State<_MatchListWidget> {



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MatchDetailWidget(matchId: widget.match.matchId);
        },));
      },
      child: CustomContainer(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  child: Text(widget.match.matchStatus.ko,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                      fontWeight: FontWeight.w600,
                      color: _matchStatusColor(context, widget.match.matchStatus)
                    ),
                  ),
                ),

                const SizedBox(width: 10,),

                Expanded(
                  child: Text(widget.match.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize
                    ),
                  ),
                ),

                const SizedBox(width: 10,),

                Text(DateFormat('HH:mm').format(widget.match.date),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize
                  ),
                )
              ],
            ),
            const SizedBox(height: 8,),
            MatchExtraDataWidget(matchData: widget.match.matchData),
          ],
        ),
      ),
    );
  }

  Color _matchStatusColor(BuildContext context, MatchStatus status) {
    return switch (status) {
      MatchStatus.OPEN => Theme.of(context).colorScheme.primary,
      MatchStatus.CLOSING_SOON => const Color(0xFFFF5D5D),
      MatchStatus.CLOSED => Theme.of(context).colorScheme.secondary,
      MatchStatus.FINISHED => Theme.of(context).colorScheme.secondary,
    };
  }

}
