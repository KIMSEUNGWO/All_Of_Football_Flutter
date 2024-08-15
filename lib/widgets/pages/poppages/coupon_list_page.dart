
import 'package:all_of_football/domain/coupon/coupon.dart';
import 'package:all_of_football/widgets/component/coupon/coupon_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CouponListWidget extends StatefulWidget {

  final bool readOnly;
  final Function(Coupon?)? onPressed;
  const CouponListWidget({
    super.key,
    this.onPressed,
    this.readOnly = true,
  });

  @override
  State<CouponListWidget> createState() => _CouponListWidgetState();
}

class _CouponListWidgetState extends State<CouponListWidget> {

  List<Coupon> _items = [
    Coupon(1, '신규회원 50% 쿠폰', 50, DateTime(2024, 08, 31, 23, 55)),
    Coupon(2, '첫 결제 30% 쿠폰', 30, DateTime(2024, 08, 31, 23, 55)),
    Coupon(3, '첫 결제 30% 쿠폰', 30, DateTime(2024, 08, 31, 23, 55)),
    Coupon(4, '첫 결제 30% 쿠폰', 30, DateTime(2024, 08, 31, 23, 55)),
    Coupon(5, '첫 결제 30% 쿠폰', 30, DateTime(2024, 08, 31, 23, 55)),
    Coupon(6, '첫 결제 30% 쿠폰', 30, DateTime(2024, 08, 31, 23, 55)),
    Coupon(7, '첫 결제 30% 쿠폰', 30, DateTime(2024, 08, 31, 23, 55)),
    Coupon(8, '첫 결제 30% 쿠폰', 30, DateTime(2024, 08, 31, 23, 55)),
    Coupon(9, '첫 결제 30% 쿠폰', 30, DateTime(2024, 08, 31, 23, 55)),
    Coupon(10, '첫 결제 30% 쿠폰', 30, DateTime(2024, 08, 31, 23, 55)),
  ];

  Coupon? _selectCoupon;

  void _select(Coupon? coupon) {
    print('_CouponListWidgetState._select');
    setState(() {
      _selectCoupon = coupon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('쿠폰함'),
        scrolledUnderElevation: 0,
        actions: widget.readOnly
          ? null
          : [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  if (widget.onPressed != null) {
                    widget.onPressed!(_selectCoupon);
                  }
                  Navigator.pop(context);
                },
                child: Text('선택',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 39,),
              if (!widget.readOnly)
                Padding(
                  padding: const EdgeInsets.only(right: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('선택 해제',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 5,),
                      GestureDetector(
                        onTap: () {
                          _select(null);
                        },
                        child: Container(
                            width: 20, height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color: Theme.of(context).colorScheme.secondary,
                                    width: 0.3
                                )
                            ),
                            child: _selectCoupon != null ? null : Center(
                              child: Container(
                                width: 15, height: 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(height: 16,),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  Coupon coupon = _items[index];
                  return GestureDetector(
                    onTap: () {
                      if (!widget.readOnly) {
                        _select(coupon);
                      }
                    },
                    child: CouponCard(
                      height: 110,
                      width: double.infinity,
                      borderRadius: 10,
                      backgroundColor: Colors.white,
                      curveAxis: Axis.vertical,
                      shadow: BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          offset: const Offset(0, 2),
                          blurRadius: 4
                      ),
                      firstChild: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: const BoxDecoration(
                          color: Color(0xFFA6D7F9),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${coupon.per}%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Theme.of(context).textTheme.displayLarge!.fontSize,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text('OFF',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Theme.of(context).textTheme.displayMedium!.fontSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      secondChild: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('COUPON',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.tertiary,
                                        fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 5
                                      ),
                                    ),
                                    const SizedBox(height: 3,),
                                    Text(coupon.title,
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Text('${DateFormat('yyyy-MM-dd HH:mm').format(coupon.expireDate)}까지',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (!widget.readOnly)
                            Positioned(
                              top: 15, right: 15,
                              child: Container(
                                width: 20, height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.secondary,
                                    width: 0.3
                                  )
                                ),
                                child: _selectCoupon != coupon ? null : Center(
                                  child: Container(
                                    width: 15, height: 15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                )
                              ),
                            ),
                        ]
                      ),

                    ),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom,)
            ],
          ),
        ),
      ),
    );
  }
}

