import 'package:all_of_football/component/datetime_formatter.dart';
import 'package:all_of_football/domain/match/match_search_view.dart';
import 'package:all_of_football/notifier/recently_match_notifier.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:all_of_football/widgets/component/match_extra_data.dart';
import 'package:all_of_football/widgets/component/match_status_box.dart';
import 'package:all_of_football/widgets/component/space_custom.dart';
import 'package:all_of_football/widgets/pages/poppages/match_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchListWidget extends ConsumerStatefulWidget {
  final MatchView match;
  final DateFormatType formatType;
  const MatchListWidget({super.key, required this.match, this.formatType = DateFormatType.TIME});

  @override
  ConsumerState<MatchListWidget> createState() => _MatchListWidgetState();
}

class _MatchListWidgetState extends ConsumerState<MatchListWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        ref.read(recentlyMatchNotifier.notifier).add(widget.match);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MatchDetailWidget(matchId: widget.match.matchId);
        },));
      },
      child: CustomContainer(
        child: Column(
          children: [
            Row(
              children: [
                MatchStatusWidget(matchStatus: widget.match.matchStatus),
                const SpaceWidth(10,),
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

                const SpaceWidth(10),

                Text(widget.formatType.format(widget.match.matchDate),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize
                  ),
                )
              ],
            ),
            const SpaceHeight(8),
            Skeleton.ignore(
              child: MatchExtraDataWidget(matchData: widget.match.matchData),
            ),
          ],
        ),
      ),
    );
  }

}


enum DateFormatType {

  TIME,
  DATETIME,
  REAMIN_TIME;


  String format(DateTime date) {
    return switch (this) {
      DateFormatType.TIME => DateFormat('HH:mm').format(date),
      DateFormatType.DATETIME => DateFormat('MM-dd HH:mm').format(date),
      DateFormatType.REAMIN_TIME => DateTimeFormatter.remainDate(date),
    };
  }

}