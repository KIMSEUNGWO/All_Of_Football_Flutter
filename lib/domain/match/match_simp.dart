
import 'package:all_of_football/domain/enums/match_enums.dart';

class MatchSimp {

  final int matchId;
  final DateTime matchDate;
  final MatchData matchData;

  MatchSimp.fromJson(Map<String, dynamic> json):
    matchId = json['matchId'],
    matchDate = DateTime.parse(json['matchDate']),
    matchData = MatchData.fromJson(json['matchData']);

  MatchSimp(this.matchId, this.matchDate, this.matchData);
}