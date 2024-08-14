
import 'package:all_of_football/domain/coupon/coupon.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:flutter/material.dart';

class CouponListWidget extends StatefulWidget {

  final bool readOnly;
  const CouponListWidget({
    super.key,
    this.readOnly = true
  });

  @override
  State<CouponListWidget> createState() => _CouponListWidgetState();
}

class _CouponListWidgetState extends State<CouponListWidget> {

  List<Coupon> _items = [
    Coupon(1, '신규회원 50% 쿠폰', 50, DateTime(2024, 08, 31, 23, 55)),
    Coupon(2, '첫 결제 30% 쿠폰', 30, DateTime(2024, 08, 31, 23, 55)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return CustomContainer();
        },
      ),
    );
  }
}
