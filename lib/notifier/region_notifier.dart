import 'dart:ui';

import 'package:all_of_football/component/local_storage.dart';
import 'package:all_of_football/component/region_data.dart';
import 'package:all_of_football/component/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionNotifier extends StateNotifier<Region> {
  RegionNotifier() : super(Region.ALL);

  init() async {
    state = await LocalStorage.findByRegion();
  }

  get() async {
    return state;
  }

  void setRegion(BuildContext context, Region newRegion) async {
    if (state == newRegion) return;
    state = newRegion;
    LocalStorage.saveByRegion(newRegion);
    CustomSnackBar.message(context, '지역을 변경했습니다.');
  }

  String getLocalName(Locale locale) {
    return state.getLocaleName(locale);
  }

}

final regionProvider = StateNotifierProvider<RegionNotifier, Region>((ref) => RegionNotifier());