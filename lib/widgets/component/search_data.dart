
import 'package:all_of_football/component/svg_icon.dart';
import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:all_of_football/domain/search_condition.dart';
import 'package:flutter/material.dart';

class SearchData extends StatefulWidget {
  final Function(SearchCondition condition) search;
  final int dateRange;
  final int selectedDateIndex;

  const SearchData({super.key, required this.search, required this.dateRange, required this.selectedDateIndex});

  @override
  State<SearchData> createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {

  late List<DateTime> dateList;
  late int _selectedDateIndex;
  SexType? _selectedSexType;

  _changeDate(int index) {
    if (_selectedDateIndex == index) return;
    setState(() => _selectedDateIndex = index);
  }

  _search() {
    SearchCondition condition = SearchCondition(
      dateTime: dateList[_selectedDateIndex],
      sexType: _selectedSexType,
      region: null,
    );
    widget.search(condition);
  }
  _changeSex(SexType? sexType) => setState(() => _selectedSexType = sexType);

  double? _containerHeight = 114;
  bool _hasOpen = false;
  _containerExpand() {
    setState(() {
      if (_containerHeight == 114) {
        _containerHeight = 214;
        _hasOpen = true;
      } else {
        _containerHeight = 114;
        _hasOpen = false;
      }
    });
  }

  @override
  void initState() {
    DateTime now = DateTime.now();
    dateList = List.generate(widget.dateRange, (index) => now.add(Duration(days: index)),);
    _selectedDateIndex = widget.selectedDateIndex;
    super.initState();
    _search();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: double.infinity,
      height: _containerHeight,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32)
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              offset: Offset(0, 2),
              blurRadius: 4
          )
        ],
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
            child: Wrap(
              runSpacing: 30,
              children: [
                _SelectDate(selectedDateIndex: _selectedDateIndex, changeDate: _changeDate, dateList: dateList),
                _SelectSex(changeSex: _changeSex, selectedSexType: _selectedSexType,),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0, right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: _containerExpand,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                  decoration: const BoxDecoration(),
                  child: _hasOpen
                    ? SvgIcon.asset(sIcon: SIcon.moreClose)
                    : SvgIcon.asset(sIcon: SIcon.more),
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}

class _SelectDate extends StatelessWidget {
  
  final int selectedDateIndex;
  final Function(int index) changeDate;
  final List<DateTime> dateList;
  
  _SelectDate({super.key, required this.selectedDateIndex, required this.changeDate, required this.dateList});

  final List<String> daysOfWeek = ['월', '화', '수', '목', '금', '토', '일'];
  String _formatDayOfWeek(DateTime date) {
    // 요일을 한글로 매핑
    return daysOfWeek[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      child: LayoutBuilder(
          builder: (context, constraints) {
            double totalWidth = constraints.maxWidth; // 전체 너비
            double containerWidth = totalWidth / 7; // 각 Container의 너비

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 14,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    changeDate(i);
                  },
                  child: Container(
                    width: containerWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selectedDateIndex == i ? Theme.of(context).colorScheme.onTertiary : Colors.white
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_formatDayOfWeek(dateList[i]),
                          style: TextStyle(
                              color: selectedDateIndex == i
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary,
                              fontWeight: selectedDateIndex == i
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Text(i == 0 || dateList[i - 1].month != dateList[i].month
                            ? '${dateList[i].month}.${dateList[i].day}'
                            : '${dateList[i].day}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: selectedDateIndex == i
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize
                          ),
                        )
                      ],
                    ),
                  ),
                );

              },
            );
          }
      ),
    );
  }
}

class _SelectSex extends StatelessWidget {

  final SexType? selectedSexType;
  final Function(SexType?) changeSex;

  _SelectSex({super.key, required this.selectedSexType, required this.changeSex});

  final List<String> titles = ['전체', '남자', '여자'];
  final List<SexType?> types = [null, SexType.MALE, SexType.FEMALE];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      child: LayoutBuilder(
          builder: (context, constraints) {
            double totalWidth = constraints.maxWidth; // 전체 너비
            double containerWidth = totalWidth / 7; // 각 Container의 너비

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: types.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    changeSex(types[index]);
                  },
                  child: Container(
                    width: containerWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: selectedSexType == types[index] ? Theme.of(context).colorScheme.onTertiary : Colors.white,
                    ),
                    child: Center(
                      child: Text(titles[index],
                        style: TextStyle(
                            color: selectedSexType == types[index]
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                            fontWeight: selectedSexType == types[index]
                                ? FontWeight.w600
                                : FontWeight.w400,
                            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
      ),
    );
  }
}

