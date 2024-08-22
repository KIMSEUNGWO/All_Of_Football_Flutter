
import 'package:all_of_football/api/service/match_service.dart';
import 'package:all_of_football/component/region_data.dart';
import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:all_of_football/domain/match/match_search_view.dart';
import 'package:all_of_football/notifier/user_notifier.dart';
import 'package:all_of_football/widgets/component/match_list.dart';
import 'package:all_of_football/widgets/form/detail_default_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchSoonDisplay extends ConsumerStatefulWidget {
  const MatchSoonDisplay({super.key});

  @override
  ConsumerState<MatchSoonDisplay> createState() => _MatchSoonDisplayState();
}

class _MatchSoonDisplayState extends ConsumerState<MatchSoonDisplay> {

  late List<MatchView> _result = [];

  _fetch() async {
    print('_MatchSoonDisplayState._fetch');
    List<MatchView> data = await MatchService.getMatchesSoon();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {
          _result = data;
        });
      }
    },);
  }

  @override
  void initState() {
    _fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('MatchSoonDisplay.build');
    final state = ref.watch(loginProvider);
    if (state == null || _result.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 36),
      child: DetailDefaultFormWidget(
        title: '게임이 곧 시작해요',
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 12,),
          itemCount: _result.length,
          itemBuilder: (context, index) => MatchListWidget(
            match: _result[index],
            formatType: DateFormatType.REAMIN_TIME,
          ),
        ),
      ),
    );
  }
}
