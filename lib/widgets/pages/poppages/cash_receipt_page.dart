

import 'package:all_of_football/api/domain/result_code.dart';
import 'package:all_of_football/api/service/user_service.dart';
import 'package:all_of_football/component/account_format.dart';
import 'package:all_of_football/component/action_sheet.dart';
import 'package:all_of_football/domain/cash/receipt.dart';
import 'package:all_of_football/domain/enums/receipt_enum.dart';
import 'package:all_of_football/notifier/user_notifier.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashReceiptWidget extends ConsumerStatefulWidget {
  const CashReceiptWidget({super.key});

  @override
  ConsumerState<CashReceiptWidget> createState() => _CashReceiptWidgetState();
}

class _CashReceiptWidgetState extends ConsumerState<CashReceiptWidget> {

  ReceiptType? _receiptType;

  late final List<Receipt> _items;

  // late List<Receipt> _items = [
  //   Receipt(title: '카카오페이', type: ReceiptType.CHARGE, date: DateTime.now(), useCash: 20000, remainCash: 20000),
  //   Receipt(title: '매치참여', type: ReceiptType.USE, date: DateTime.now(), useCash: -10000, remainCash: 10000),
  //   Receipt(title: '[30%] 매치 3일전 취소', type: ReceiptType.CANCEL, date: DateTime.now(), useCash: 3000, remainCash: 13000),
  //   Receipt(title: '[100%] 기상악화로 인한 환불', type: ReceiptType.REFUND, date: DateTime.now(), useCash: 10000, remainCash: 23000),
  //   Receipt(title: '라인페이', type: ReceiptType.CHARGE, date: DateTime.now(), useCash: 30000, remainCash: 53000),
  // ];

  List<Receipt> _showItems = [];

  void setReceiptType(ReceiptType? type) {
    if (type == _receiptType) return;
    setState(() {
      _receiptType = type;
      _showItems = _items.where((receipt) => _receiptType == null || _receiptType == receipt.type).toList();
    });
  }

  _fetchReceipt() async {
    _items = await UserService.getReceipt();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _showItems = _items;
      });
    },);

  }

  @override
  void initState() {
    _fetchReceipt();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text('캐시 내역'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 36,),

              CustomContainer(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('잔액',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(AccountFormatter.format(ref.read(loginProvider)?.cash),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32,),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    final action = ActionSheet<ReceiptType?>(
                      actions: _getActions(),
                    );
                    action.showBottomActionSheet(context);
                  },
                  child: CustomContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(ReceiptType.lang(_receiptType),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontStyle: Theme.of(context).textTheme.bodyLarge!.fontStyle,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(width: 5,),
                        const Icon(Icons.keyboard_arrow_down_rounded,)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16,),

              (_showItems.isEmpty)
              ? Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text('내역이 없습니다',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: Theme.of(context).textTheme.displaySmall!.fontSize
                  ),
                ),
              )
              : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _showItems.length,
                itemBuilder: (context, index) {
                  Receipt receipt = _showItems[index];
                  return CustomContainer(
                    height: 85,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    margin: const EdgeInsets.only(bottom: 11),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateFormat('yyyy.MM.dd HH:mm').format(receipt.date),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(ReceiptType.lang(receipt.type),
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                                fontWeight: FontWeight.w400,
                                color: typeColor(receipt.type),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(receipt.title,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(AccountFormatter.format(receipt.useCash, showSign: true),
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                                fontWeight: FontWeight.w600,
                                color: typeColor(receipt.type),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 2,),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('잔액 ${AccountFormatter.format(receipt.remainCash)}',
                            style: TextStyle(
                              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Color typeColor(ReceiptType? type) {
    return switch (type) {
      ReceiptType.CHARGE => const Color(0xFFE30000),
      ReceiptType.USE => const Color(0xFF4C6DDF),
      ReceiptType.CANCEL || ReceiptType.REFUND || null  => Theme.of(context).colorScheme.primary,
    };
  }

  List<ActionTile<ReceiptType?>> _getActions() {
    return [
      ActionTile<ReceiptType?>(
        title: '전체',
        type: null,
        onPressed: (p0) => setReceiptType(p0),
      ),
      ActionTile<ReceiptType?>(
        title: '사용',
        type: ReceiptType.USE,
        onPressed: (p0) => setReceiptType(p0),
      ),
      ActionTile<ReceiptType?>(
        title: '충전',
        type: ReceiptType.CHARGE,
        onPressed: (p0) => setReceiptType(p0),
      ),
      ActionTile<ReceiptType?>(
        title: '취소',
        type: ReceiptType.CANCEL,
        onPressed: (p0) => setReceiptType(p0),
      ),
      ActionTile<ReceiptType?>(
        title: '환불',
        type: ReceiptType.REFUND,
        onPressed: (p0) => setReceiptType(p0),
      ),
    ];
  }
}
