
import 'package:all_of_football/component/region_data.dart';
import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:all_of_football/domain/match/match_search_view.dart';
import 'package:all_of_football/domain/search_condition.dart';
import 'package:all_of_football/notifier/region_notifier.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:all_of_football/widgets/component/custom_scroll_refresh.dart';
import 'package:all_of_football/widgets/component/match_extra_data.dart';
import 'package:all_of_football/widgets/component/match_list.dart';
import 'package:all_of_football/widgets/component/search_data.dart';
import 'package:all_of_football/widgets/pages/poppages/match_detail_page.dart';
import 'package:all_of_football/widgets/pages/poppages/region_select_page.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MatchListPageWidget extends ConsumerStatefulWidget {
  const MatchListPageWidget({super.key});

  @override
  ConsumerState<MatchListPageWidget> createState() => _MatchListPageWidgetState();
}

class _MatchListPageWidgetState extends ConsumerState<MatchListPageWidget> with AutomaticKeepAliveClientMixin {

  final _dateRange = 30;
  int _currentDateIndex = 0;
  bool _loading = false;
  
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


  late SearchCondition _condition;

  _selectRegion(Region region) async {
    ref.read(regionProvider.notifier).setRegion(context, region);
    Region newRegion = await ref.read(regionProvider.notifier).get();
    if (_condition.region == newRegion) return;
    _search(
      SearchCondition(
        dateTime: _condition.dateTime,
        sexType: _condition.sexType,
        region: newRegion
      )
    );
  }

  _search(SearchCondition condition) {
    print('_MatchListPageWidgetState.search');
    print(condition.dateTime);
    print(condition.sexType);
    print(condition.region);
    _condition = condition;
  }
  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return RegionSelectWidget(
                onPressed: _selectRegion,
              );
            },));
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(ref.watch(regionProvider).getLocaleName(const Locale('ko', 'KR')),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Icon(Icons.keyboard_arrow_down_rounded)
            ]
          ),
        ),

      ),

      body: Column(
        children: [
          SearchData(search: _search, dateRange: _dateRange, selectedDateIndex: _currentDateIndex),

          Expanded(
            child: Skeletonizer(
              enabled: _loading,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: _items.isEmpty
                ? Center(
                 child: Text('매치가 없어요',
                   style: TextStyle(
                     fontSize: Theme.of(context).textTheme.displayMedium!.fontSize
                   ),
                 ),
                )
                : CustomScrollView(
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
                          return MatchListWidget(match: _items[index]);
                        },
                      ),
                    ],
                  ),
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

