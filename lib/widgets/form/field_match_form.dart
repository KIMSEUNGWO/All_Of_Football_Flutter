
import 'package:all_of_football/component/region_data.dart';
import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:all_of_football/domain/match/match_simp.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:all_of_football/widgets/component/match_extra_data.dart';
import 'package:all_of_football/widgets/component/match_status_box.dart';
import 'package:all_of_football/widgets/form/detail_default_form.dart';
import 'package:all_of_football/domain/match/match.dart';
import 'package:all_of_football/widgets/pages/poppages/match_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class FieldMatchFormWidget extends StatefulWidget {

  final int fieldId;

  const FieldMatchFormWidget({super.key, required this.fieldId});

  @override
  State<FieldMatchFormWidget> createState() => _FieldMatchFormWidgetState();
}

class _FieldMatchFormWidgetState extends State<FieldMatchFormWidget> {

  final List<MatchSimp> matchList = [];

  @override
  void initState() {
    matchList.add(MatchSimp(1, DateTime.now(), MatchData(null, Region.TAITO, 5, 3), MatchStatus.OPEN));
    matchList.add(MatchSimp(1, DateTime.now(), MatchData(SexType.FEMALE, Region.TAITO, 6, 3),MatchStatus.OPEN));
    matchList.add(MatchSimp(1, DateTime.now(), MatchData(SexType.MALE, Region.TAITO, 6, 2),MatchStatus.OPEN));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DetailDefaultFormWidget(
      title: '일정',
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(height: 10,),
        itemCount: matchList.length,
        itemBuilder: (context, index) {
          MatchSimp simp = matchList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MatchDetailWidget(matchId: simp.matchId);
              },));
            },
            child: CustomContainer(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(DateFormat('MM.dd').format(simp.matchDate),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Text(DateFormat('HH:mm').format(simp.matchDate),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          MatchStatusWidget(matchStatus: simp.matchStatus),
                          const SizedBox(width: 5,),
                          Icon(Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  Row(
                    children: [
                      _sexTypeColor(context, simp.matchData.sexType),
                      Text('${SexType.getName(simp.matchData.sexType)} · ${simp.matchData.person} vs ${simp.matchData.person} ${simp.matchData.matchCount}파전',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _sexTypeColor(BuildContext context, SexType? sexType) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 5, height: 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color:
          (sexType == SexType.MALE) ? const Color(0xFF3534A5)
              : (sexType == SexType.FEMALE) ? const Color(0xFFFF5D5D)
              : const Color(0xFFFFC645)
      ),
    );
  }

  Widget dot(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text('·',
        style: TextStyle(
            color: Theme.of(context).colorScheme.secondary
        ),
      ),
    );
  }
}
