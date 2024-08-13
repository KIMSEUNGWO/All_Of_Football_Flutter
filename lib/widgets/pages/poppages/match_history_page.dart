
import 'package:all_of_football/widgets/component/calender.dart';
import 'package:flutter/material.dart';

class MatchHistoryWidget extends StatefulWidget {
  const MatchHistoryWidget({super.key});

  @override
  State<MatchHistoryWidget> createState() => _MatchHistoryWidgetState();
}

class _MatchHistoryWidgetState extends State<MatchHistoryWidget> {

  void _selectDate(DateTime date) {
    print('날짜 변경감지 : $date');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('경기내역'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              CalenderWidget(
                onChanged: _selectDate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
