
import 'package:all_of_football/component/image_helper.dart';
import 'package:all_of_football/domain/field/address.dart';
import 'package:all_of_football/domain/field/field_data.dart';
import 'package:flutter/material.dart';

class Field {

  final int fieldId;
  final String title;
  final Address address;
  final FieldData fieldData;
  final String description;
  final bool favorite;
  final List<Image> images;

  Field.fromJson(Map<String, dynamic> json):
    fieldId = json['fieldId'],
    title = json['title'],
    description = json['description'],
    address = Address.fromJson(json['address']),
    fieldData = FieldData.fromJson(json['fieldData']),
    favorite = json['favorite'] ?? false,
    images = json['images'] != null
      ? List<Image>.from(json['images'].map((image) => ImageHelper.parseImage(imagePath: ImagePath.ORIGINAL, imageType: ImageType.FIELD, imageName: image, fit: BoxFit.fitWidth)))
      : [];

  Field(this.fieldId, this.title, this.address, this.fieldData,
      this.favorite,
      this.description, this.images);
}