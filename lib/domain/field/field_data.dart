
import 'package:all_of_football/component/image_helper.dart';
import 'package:all_of_football/domain/enums/field_enums.dart';
import 'package:flutter/material.dart';

class FieldData {

  final Parking parking;
  final Shower shower;
  final Toilet toilet;
  final int sizeX;
  final int sizeY;
  final int hourPrice;

  FieldData.fromJson(Map<String, dynamic> json):
    parking = Parking.valueOf(json['parking']),
    shower = Shower.valueOf(json['shower']),
    toilet = Toilet.valueOf(json['toilet']),
    sizeX = json['sizeX'],
    sizeY = json['sizeY'],
    hourPrice = json['hourPrice'];

  FieldData(this.parking, this.shower, this.toilet, this.sizeX, this.sizeY,
      this.hourPrice);
}

class FieldImage {

  final int? imageId;
  final String path;
  final Image image;

  FieldImage.fromJson(Map<String, dynamic> json):
      imageId = json['imageId'],
      path = json['attachedImage'],
      image = ImageHelper.parseImage(imagePath: ImagePath.ORIGINAL, imageType: ImageType.FIELD, imageName: json['image'], fit: BoxFit.fitWidth);

  FieldImage(this.imageId, this.path, this.image);
}