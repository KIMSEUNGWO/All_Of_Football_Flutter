
import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:all_of_football/domain/field/field.dart';

class Match {

  final int matchId;
  final DateTime matchDate;
  final SexType? sexType;
  final int person;
  final int matchCount;
  final int matchHour;
  final Field field;

  Match.fromJson(Map<String, dynamic> json):
    matchId = json['matchId'],
    matchDate = DateTime.parse(json['matchDate']),
    sexType = SexType.valueOf(json['sexType']),
    person = json['person'],
    matchCount = json['matchCount'],
    matchHour = json['matchHour'],
    field = Field.fromJson(json['field']);

  Match(this.matchId, this.matchDate, this.sexType, this.person,
      this.matchCount, this.matchHour, this.field);
}