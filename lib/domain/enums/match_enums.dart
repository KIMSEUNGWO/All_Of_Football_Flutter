
import 'package:all_of_football/component/region_data.dart';
import 'package:flutter/material.dart';

class MatchData {

  final SexType? sexType;
  final Region? region;
  final int person;
  final int matchCount;

  MatchData.fromJson(Map<String, dynamic> json):
    sexType = SexType.valueOf(json['sexType']),
    region = Region.valueOf(json['region']),
    person = json['person'],
    matchCount = json['matchCount'];

  MatchData(this.sexType, this.region, this.person, this.matchCount);
}

enum MatchStatus {

  OPEN('모집중'),           // 모집중
  CLOSING_SOON('마감임박'),   // 마감임박
  CLOSED('마감'),         // 마감
  FINISHED('종료');        // 경기종료

  final String ko;

  const MatchStatus(this.ko);

  static MatchStatus valueOf(String? data) {
    List<MatchStatus> values = MatchStatus.values;
    for (var o in values) {
      if (o.name == data) return o;
    }
    return MatchStatus.FINISHED;
  }

  Color backgroundColor(BuildContext context) {
    return switch (this) {
      MatchStatus.OPEN => Theme.of(context).colorScheme.onPrimary,
      MatchStatus.CLOSING_SOON => const Color(0xFFFF5D5D),
      MatchStatus.CLOSED => Theme.of(context).colorScheme.secondary,
      MatchStatus.FINISHED => Theme.of(context).colorScheme.secondary,
    };
  }
}


enum SexType {

  MALE,
  FEMALE;

  static SexType? valueOf(String? data) {
    List<SexType> values = SexType.values;
    for (var o in values) {
      if (o.name == data) return o;
    }
    return null;
  }

  static String getName(SexType? data) {
    if (data == SexType.MALE) return '남자만';
    if (data == SexType.FEMALE) return '여자만';
    return '남녀무관';
  }
}


