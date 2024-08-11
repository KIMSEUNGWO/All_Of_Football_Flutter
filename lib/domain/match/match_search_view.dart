
import 'package:all_of_football/domain/enums/match_enums.dart';

class MatchView {

  final int matchId;
  final MatchStatus matchStatus;
  final String title;
  final DateTime date;
  final MatchData matchData;

  MatchView.fromJson(Map<String, dynamic> json):
    matchId = json['matchId'],
    matchStatus = MatchStatus.valueOf(json['matchStatus']),
    title = json['title'],
    date = DateTime.parse(json['date']),
    matchData = MatchData.fromJson(json['matchData']);

  MatchView(
      this.matchId, this.matchStatus, this.title, this.date, this.matchData);
}