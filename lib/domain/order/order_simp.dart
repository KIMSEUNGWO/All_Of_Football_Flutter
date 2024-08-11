
import 'package:all_of_football/domain/coupon/coupon.dart';
import 'package:all_of_football/domain/field/address.dart';

class OrderSimp {

  final String title;
  final int totalPrice;
  final int matchHour;

  final Address address;
  final DateTime dateTime;

  final int cash;
  final List<Coupon> couponList;

  OrderSimp.fromJson(Map<String, dynamic> json):
    title = json['title'],
    matchHour = json['matchHour'],
    totalPrice = json['totalPrice'],
    address = Address.fromJson(json['address']),
    dateTime = DateTime.parse(json['dateTime']),
    cash = json['cash'],
    couponList = json['couponList'] != null
      ? List<Coupon>.from(json['couponList'].map((coupon) => Coupon.fromJson(coupon)))
      : [];

  OrderSimp({required this.title, required this.matchHour, required this.totalPrice, required this.address, required this.dateTime, required this.cash, required this.couponList});


}