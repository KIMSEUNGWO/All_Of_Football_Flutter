
import 'package:all_of_football/component/region_data.dart';
import 'package:all_of_football/domain/field/field_simp.dart';
import 'package:all_of_football/notifier/favorite_notifier.dart';
import 'package:all_of_football/widgets/component/favorite_field_list.dart';
import 'package:all_of_football/widgets/form/detail_default_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteFieldDisplay extends ConsumerStatefulWidget {
  const FavoriteFieldDisplay({super.key});

  @override
  ConsumerState<FavoriteFieldDisplay> createState() => _FavoriteFieldDisplayState();
}

class _FavoriteFieldDisplayState extends ConsumerState<FavoriteFieldDisplay> {

  @override
  Widget build(BuildContext context) {

    List<FieldSimp> favorites = ref.watch(favoriteNotifier);

    if (favorites.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 36),
      child: DetailDefaultFormWidget(
        title: '즐겨찾는 구장',
        titlePadding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 20,),
              ... favorites.map((x) => FavoriteFieldListWidget(fieldSimp: x)),
              const SizedBox(width: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
