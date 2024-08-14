import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:all_of_football/domain/match/match_search_view.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:all_of_football/widgets/component/match_extra_data.dart';
import 'package:all_of_football/widgets/pages/poppages/match_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MatchListWidget extends StatefulWidget {
  final MatchView match;
  const MatchListWidget({super.key, required this.match,});

  @override
  State<MatchListWidget> createState() => _MatchListWidgetState();
}

class _MatchListWidgetState extends State<MatchListWidget> {



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
            Skeleton.ignore(
              child: MatchExtraDataWidget(matchData: widget.match.matchData),
            ),
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
