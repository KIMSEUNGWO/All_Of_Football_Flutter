
import 'package:all_of_football/component/image_helper.dart';
import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:flutter/material.dart';

class UserProfile {

  final int id;
  Image? image;
  String nickname;
  final SexType sex;
  final DateTime birth;

  int couponCount;

  int cash;



  UserProfile.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    image = json['image'] == null
        ? null
        : ImageHelper.parseImage(imagePath: ImagePath.ORIGINAL, imageType: ImageType.PROFILE, imageName: json['image'], fit: BoxFit.fill),
    nickname = json['nickname'],
    sex = SexType.valueOf(json['sex'])!,
    birth = DateTime.parse(json['birth']),
    couponCount = json['couponCount'],
    cash = json['cash'];

}