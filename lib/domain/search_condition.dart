
import 'package:all_of_football/component/region_data.dart';
import 'package:all_of_football/domain/enums/match_enums.dart';

class SearchCondition {

  final DateTime date;
  final SexType? sexType;
  final Region? region;

  SearchCondition({required this.date, required this.sexType, required this.region});

}