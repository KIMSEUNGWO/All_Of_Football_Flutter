
import 'package:all_of_football/component/region_data.dart';
import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:all_of_football/domain/match/match_simp.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:all_of_football/widgets/component/match_extra_data.dart';
import 'package:all_of_football/widgets/form/detail_default_form.dart';
import 'package:all_of_football/domain/match/match.dart';
import 'package:all_of_football/widgets/pages/poppages/match_detail_page.dart';
import 'package:flutter/material.dart';
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
    matchList.add(MatchSimp(1, DateTime.now(), MatchData(null, Region.TAITO, 5, 3)));
    matchList.add(MatchSimp(1, DateTime.now(), MatchData(SexType.FEMALE, Region.TAITO, 6, 3)));
    matchList.add(MatchSimp(1, DateTime.now(), MatchData(SexType.MALE, Region.TAITO, 6, 2)));
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
              child: Row(
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
                      MatchExtraDataWidget(matchData: simp.matchData),
                      const SizedBox(width: 10,),
                      Icon(Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
