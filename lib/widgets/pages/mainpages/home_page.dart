
import 'package:all_of_football/widgets/pages/poppages/login_page.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomeWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginWidget();
              }, fullscreenDialog: true));
            },
            child: Text('로그인 페이지 이동',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
