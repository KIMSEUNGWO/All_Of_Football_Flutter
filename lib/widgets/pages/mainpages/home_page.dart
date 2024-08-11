
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
    return const Placeholder();
  }

  @override
  bool get wantKeepAlive => true;
}
