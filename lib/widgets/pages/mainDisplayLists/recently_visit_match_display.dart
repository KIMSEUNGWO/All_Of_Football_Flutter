
import 'dart:math';

import 'package:all_of_football/domain/match/match_search_view.dart';
import 'package:all_of_football/notifier/recently_match_notifier.dart';
import 'package:all_of_football/widgets/component/match_list.dart';
import 'package:all_of_football/widgets/pages/poppages/recently_visit_match_more_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentlyVisitMatchDisplay extends ConsumerStatefulWidget {
  const RecentlyVisitMatchDisplay({super.key});

  @override
  ConsumerState<RecentlyVisitMatchDisplay> createState() => _RecentlyVisitMatchDisplayState();
}

class _RecentlyVisitMatchDisplayState extends ConsumerState<RecentlyVisitMatchDisplay> {

  final int maxLine = 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<MatchView> items = ref.watch(recentlyMatchNotifier);
    if (items.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('최근 본 매치',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                if (items.length > maxLine)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const RecentlyVisitMatchMoreWidget();
                      },));
                    },
                    child: Row(
                      children: [
                        Text('더보기',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 2,),
                        Icon(Icons.arrow_forward_ios_rounded,
                          size: Theme.of(context).textTheme.bodyMedium!.fontSize,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),

          const SizedBox(height: 10,),

          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(height: 16,),
            itemCount: min(items.length, maxLine),
            itemBuilder: (context, index) {
              MatchView data = items[index];
              return MatchListWidget(
                match: data,
                formatType: DateFormatType.DATETIME,
              );
            },
          )
        ],
      ),
    );
  }
}
