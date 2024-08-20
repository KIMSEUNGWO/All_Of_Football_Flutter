
import 'package:all_of_football/api/domain/result_code.dart';
import 'package:all_of_football/api/service/field_service.dart';
import 'package:all_of_football/component/alert.dart';
import 'package:all_of_football/component/open_app.dart';
import 'package:all_of_football/domain/field/field.dart';
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

  late Field? field;
  bool _loading = true;

  fetchField() async {
    if (widget.field != null) {
      field = widget.field!;
      setState(() {
        _loading = false;
      });
    } else {
      final response = await FieldService.getField(fieldId: widget.fieldId);
      ResultCode result = response.resultCode;
      if (result == ResultCode.OK) {
        setState(() {
          field = Field.fromJson(response.data);
          _loading = false;
        });
      } else if (result == ResultCode.FIELD_NOT_EXISTS) {
        Alert.of(context).message(
          message: '존재하지 않는 구장입니다..',
          onPressed: () {
            Navigator.pop(context);
          },
        );
      }
    }
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
          child: Text(_loading ? '' : field!.title),
        ),
        actions: [
          Skeletonizer(
            enabled: _loading,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: _loading
                ? null
                : FavoriteIconButtonWidget(fieldId: field!.fieldId, on: field!.favorite)
            ),
          ),
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
                    images: _loading ? [] : field!.images.map((image) {
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
                  Text(_loading ? '' : field!.title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: Theme.of(context).textTheme.displayMedium!.fontSize
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!_loading) {
                        OpenApp().openMaps(lat: field!.address.lat, lng: field!.address.lng);
                      }
                    },
                    child: Text(_loading ? '' : field!.address.address,
                      style: TextStyle(
                          color: const Color(0xFF686868),
                          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),


                  const SizedBox(height: 35,),
                  FieldDetailFormWidget(field: _loading ? null : field),
                  const SizedBox(height: 30,),
                  if (!_loading)
                    FieldMatchFormWidget(fieldId: field!.fieldId),
                  const SizedBox(height: 40,),


                ]
            ),
          ),
        ),
      ),
    );
  }
}
