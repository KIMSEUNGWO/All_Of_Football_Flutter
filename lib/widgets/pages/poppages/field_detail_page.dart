
import 'package:all_of_football/component/open_app.dart';
import 'package:all_of_football/component/region_data.dart';
import 'package:all_of_football/component/svg_icon.dart';
import 'package:all_of_football/domain/enums/field_enums.dart';
import 'package:all_of_football/domain/field/address.dart';
import 'package:all_of_football/domain/field/field.dart';
import 'package:all_of_football/domain/field/field_data.dart';
import 'package:all_of_football/widgets/component/favorite_icon_button.dart';
import 'package:all_of_football/widgets/component/image_detail_view.dart';
import 'package:all_of_football/widgets/form/detail_field_form.dart';
import 'package:all_of_football/widgets/form/field_image_preview.dart';
import 'package:all_of_football/widgets/form/field_match_form.dart';
import 'package:flutter/material.dart';

import 'package:skeletonizer/skeletonizer.dart';

class FieldDetailWidget extends StatefulWidget {

  final int fieldId;
  final Field? field;

  const FieldDetailWidget({super.key, required this.fieldId, this.field});

  @override
  State<FieldDetailWidget> createState() => _FieldDetailWidgetState();
}

class _FieldDetailWidgetState extends State<FieldDetailWidget> {

  late Field field;
  bool _loading = false;

  fetchField() async {
    field = widget.field ??
        Field(2, '안양대학교 SKY 풋살파크 C구장',
          Address('서울 마포구 독막로 2', Region.TAITO, 35.757721, 139.527805),
          FieldData(Parking.FREE, Shower.Y, Toilet.N, 123, 40, 10000),
          true,
          '뭐가 없고~ 뭐가 있고~',
          [
            Image.asset('assets/구장예제사진1.jpeg', fit: BoxFit.fill,),
            Image.asset('assets/구장예제사진2.jpg', fit: BoxFit.fill,),
            Image.asset('assets/구장예제사진3.jpg', fit: BoxFit.fill,)
          ]
        );
  }

  @override
  void initState() {
    fetchField();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Skeletonizer(
          enabled: _loading,
          child: Text(field.title),
        ),
        actions: [
          Skeletonizer(
            enabled: _loading,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: FavoriteIconButtonWidget(fieldId: field.fieldId, on: field.favorite)
            ),
          )
        ],
      ),
      body: Skeletonizer(
        enabled: _loading,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageSlider(
                    images: field.images.map((image) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ImageDetailView(image: image)
                                  ,fullscreenDialog: true
                              ));
                        },
                        child: image,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 19,),
                  Text(field.title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: Theme.of(context).textTheme.displayMedium!.fontSize
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      OpenApp().openMaps(lat: field.address.lat, lng: field.address.lng);
                    },
                    child: Text(field.address.address,
                      style: TextStyle(
                          color: const Color(0xFF686868),
                          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),


                  const SizedBox(height: 35,),
                  FieldDetailFormWidget(field: field),
                  const SizedBox(height: 30,),
                  FieldMatchFormWidget(fieldId: field.fieldId),
                  const SizedBox(height: 40,),


                ]
            ),
          ),
        ),
      ),
    );
  }
}
