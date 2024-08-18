
import 'package:all_of_football/component/region_data.dart';

class FieldSimp {

  final int fieldId;
  final String title;
  final Region region;
  final String address;
  final bool favorite;

  FieldSimp.fromJson(Map<String, dynamic> json):
    fieldId = json['fieldId'],
    title = json['title'],
    favorite = json['favorite'],
    region = Region.valueOf(json['region']) ?? Region.ALL,
    address = json['address'];

  FieldSimp(this.fieldId, this.title, this.address, this.favorite, this.region);
}