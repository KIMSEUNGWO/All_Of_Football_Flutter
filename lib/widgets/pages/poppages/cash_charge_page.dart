
import 'package:all_of_football/component/account_format.dart';
import 'package:all_of_football/component/svg_icon.dart';
import 'package:all_of_football/domain/enums/payment.dart';
import 'package:all_of_football/domain/user/social_result.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:all_of_football/widgets/component/policy_widget.dart';
import 'package:all_of_football/widgets/form/detail_default_form.dart';
import 'package:flutter/material.dart';

class CashChargeWidget extends StatefulWidget {
  const CashChargeWidget({super.key});

  @override
  State<CashChargeWidget> createState() => _CashChargeWidgetState();
}

class _CashChargeWidgetState extends State<CashChargeWidget> {

  final List<int> _amounts = [
    100, 10000, 20000, 30000, 40000, 50000, 100000
  ];
  final List<Payment> _payments = Payment.values;

  int? _selectAmountIndex;
  int? _selectPaymentIndex;
  bool _canSubmit = false;

  _notNullCheck(bool policy) {
    bool result = policy && _selectAmountIndex != null && _selectPaymentIndex != null;
    setState(() {
      _canSubmit = result;
    });
  }

  _setAmount(int index) {
    setState(() {
      _selectAmountIndex = index;
    });
  }
  _setPayment(int index) {
    setState(() {
      _selectPaymentIndex = index;
    });
  }

  _submit() {
    int amount = _amounts[_selectAmountIndex ?? 0];
    Payment payment = _payments[_selectPaymentIndex ?? 0];
    print('payment : $payment, amount : $amount');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('충전'),
        scrolledUnderElevation: 0,
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
                      child: Text(AccountFormatter.format(200000000),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 45,),
              DetailDefaultFormWidget(
                title: '충전할 금액',
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2
                  ),
                  itemCount: _amounts.length,
                  itemBuilder: (context, index) {
                    int amount = _amounts[index];
                    return GestureDetector(
                      onTap: () {
                        _setAmount(index);
                      },
                      child: CustomContainer(
                        backgroundColor: _selectAmountIndex == index ? Theme.of(context).colorScheme.onPrimary : null,
                        child: Center(
                          child: Text(AccountFormatter.format(amount),
                            style: TextStyle(
                              color: _selectAmountIndex == index ? Colors.white : Theme.of(context).colorScheme.primary,
                              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                              fontWeight: _selectAmountIndex == index ? FontWeight.w600 : FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              DetailDefaultFormWidget(
                title: '결제방식',
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2
                  ),
                  itemCount: _payments.length,
                  itemBuilder: (context, index) {
                    Payment payment = _payments[index];
                    return GestureDetector(
                      onTap: () {
                        _setPayment(index);
                      },
                      child: CustomContainer(
                        backgroundColor: payment.backgroundColor,
                        border: _selectPaymentIndex == index ? Border.all(
                          color: Theme.of(context).colorScheme.onPrimary,
                          width: 4
                        ) : null,
                        child: Center(
                          child: SvgIcon.asset(sIcon: payment.getLogo()),
                        ),
                      ),
                    );
                  },
                ),
              ),
              PolicyWidget(
                canSubmit: _notNullCheck,
              ),
              const SizedBox(height: 45,),
              GestureDetector(
                onTap: () {
                  if (!_canSubmit) return;
                  _submit();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: _canSubmit
                      ? Theme.of(context).colorScheme.onPrimary
                      : const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text('충전',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
