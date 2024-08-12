

import 'package:all_of_football/component/svg_icon.dart';
import 'package:all_of_football/widgets/component/bottom_bar_widget.dart';
import 'package:all_of_football/widgets/pages/mainpages/home_page.dart';
import 'package:all_of_football/widgets/pages/mainpages/match_list_page_new.dart';
import 'package:all_of_football/widgets/pages/mainpages/search_page.dart';
import 'package:all_of_football/widgets/pages/mainpages/mypage_page.dart';
import 'package:flutter/material.dart';


class App extends StatefulWidget {

  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  late PageController _pageController;

  int _currentIndex = 0;

  onChangePage(int index) {
    setState(() { _currentIndex = index;});
    _pageController.jumpToPage(index);
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeWidget(),
          SearchWidget(),
          MatchListPageWidget(),
          MyPageWidget(),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        height: 57,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomIcon(
              sIcon: SIcon.home,
              callback: () => onChangePage(0),
              isPressed: _currentIndex == 0,
            ),
            BottomIcon(
              sIcon: SIcon.search,
              callback: () => onChangePage(1),
              isPressed: _currentIndex == 1,
            ),
            BottomIcon(
              sIcon: SIcon.clipboard,
              callback: () => onChangePage(2),
              isPressed: _currentIndex == 2,
            ),
            BottomIcon(
              sIcon: SIcon.person,
              callback: () => onChangePage(3),
              // callback: () {
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //     return LoginWidget();
              //   },fullscreenDialog: true));
              // },
              isPressed: _currentIndex == 3,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomIcon extends StatelessWidget {

  final SIcon sIcon;
  final GestureTapCallback callback;
  final bool isPressed;

  const BottomIcon({super.key, required this.sIcon, required this.callback, required this.isPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(),
        child: SvgIcon.asset(
          sIcon: sIcon,
          style: isPressed
            ? SvgIconStyle(color: Theme.of(context).colorScheme.onPrimary)
            : null
        ),
      ),
    );
  }
}

