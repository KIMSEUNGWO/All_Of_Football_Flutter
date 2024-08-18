
import 'package:all_of_football/domain/field/address.dart';
import 'package:all_of_football/domain/field/field_data.dart';

class Field {

  final int fieldId;
  final String title;
  final Address address;
  final FieldData fieldData;
  final String description;
  final bool favorite;
  final List<FieldImage> images;

  Field.fromJson(Map<String, dynamic> json):
    fieldId = json['fieldId'],
    title = json['title'],
    description = json['description'],
    address = Address.fromJson(json['address']),
    fieldData = FieldData.fromJson(json['fieldData']),
    favorite = json['favorite'],
    images = json['images'] != null
      ? List<FieldImage>.from(json['images'].map((image) => FieldImage.fromJson(image)))
      : [];

  Field(this.fieldId, this.title, this.address, this.fieldData,
      this.favorite,
      this.description, this.images);
}