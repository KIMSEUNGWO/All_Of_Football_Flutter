
import 'package:all_of_football/component/region_data.dart';
import 'package:all_of_football/domain/enums/language_enum.dart';


class FindRegion {

  static List<Region> search(String word) {
    LanguageType langType = LanguageType.getLangType(word);

    List<Region> result = [];

    Region.values
        .where((region) => region != Region.ALL && region.isStartWith(langType, word))
        .forEach((region) => result.add(region));

    if (result.isEmpty) {
      RegionParent.values
          .where((region) => region != RegionParent.ALL && region.isStartWith(langType, word))
          .forEach((region) => result.addAll(region.getRegionChildList()));
    }

    result.sort((a, b) => a.compareTo(b, langType));

    return result;
  }

}