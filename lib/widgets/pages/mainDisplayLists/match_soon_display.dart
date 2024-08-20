
import 'package:all_of_football/component/region_data.dart';
import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:all_of_football/domain/match/match_search_view.dart';
import 'package:all_of_football/widgets/component/match_list.dart';
import 'package:all_of_football/widgets/form/detail_default_form.dart';
import 'package:flutter/material.dart';

class MatchSoonDisplay extends StatefulWidget {
  const MatchSoonDisplay({super.key});

  @override
  State<MatchSoonDisplay> createState() => _MatchSoonDisplayState();
}

class _MatchSoonDisplayState extends State<MatchSoonDisplay> {

  List<MatchView> result = [
    MatchView(100, MatchStatus.OPEN, '안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(null, Region.BUNKYO, 5, 3)),
    MatchView(2, MatchStatus.CLOSING_SOON, '안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(SexType.MALE, Region.BUNKYO, 5, 2)),
    MatchView(3, MatchStatus.CLOSED, '안양대학교 SKY 풋살파크 C구장안양대학교 SKY 풋살파크 C구장안양대학교 SKY 풋살파크 C구장', DateTime.now(), MatchData(SexType.FEMALE, Region.BUNKYO, 6, 3)),
    MatchView(4, MatchStatus.FINISHED, '어딘가의 구장', DateTime(2024, 01, 1, 1,1), MatchData(null, Region.BUNKYO, 6, 2)),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DetailDefaultFormWidget(
        title: '게임이 곧 시작해요',
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 12,),
          itemCount: result.length,
          itemBuilder: (context, index) => MatchListWidget(
            match: result[index],
            formatType: DateFormatType.REAMIN_TIME,
          ),
        ),
      ),
    );
  }
}
