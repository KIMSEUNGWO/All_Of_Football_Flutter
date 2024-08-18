
import 'package:all_of_football/component/region_data.dart';
import 'package:all_of_football/domain/field/field_simp.dart';
import 'package:all_of_football/widgets/component/favorite_field_list.dart';
import 'package:all_of_football/widgets/form/detail_default_form.dart';
import 'package:flutter/material.dart';

class FavoriteFieldDisplay extends StatefulWidget {
  const FavoriteFieldDisplay({super.key});

  @override
  State<FavoriteFieldDisplay> createState() => _FavoriteFieldDisplayState();
}

class _FavoriteFieldDisplayState extends State<FavoriteFieldDisplay> {

  List<FieldSimp> favorites = [
    FieldSimp(1, '안양대학교 SKY 풋살파크1', '서울 마포구 독막로 2', true, Region.TAITO),
    FieldSimp(2, '안양대학교 SKY 풋살파크2', '서울 마포구 독막로 2', true, Region.TAITO),
    FieldSimp(3, '안양대학교 SKY 풋살파크3', '서울 마포구 독막로 2', true, Region.TAITO),
    FieldSimp(4, '안양대학교 SKY 풋살파크4', '서울 마포구 독막로 2', true, Region.TAITO),
  ];

  onChanged(FieldSimp field) {
    print('field title : ${field.title}, favorite : ${field.favorite}');
  }

  @override
  Widget build(BuildContext context) {
    return DetailDefaultFormWidget(
      title: '즐겨찾는 구장',
      titlePadding: const EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 20,),
            ... favorites.map((x) => FavoriteFieldListWidget(fieldSimp: x, onChanged: onChanged)).toList(),
            const SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}
