

import 'package:all_of_football/notifier/region_notifier.dart';
import 'package:all_of_football/notifier/user_notifier.dart';
import 'package:all_of_football/widgets/app.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitApp extends ConsumerStatefulWidget {
  const InitApp({super.key});

  @override
  ConsumerState<InitApp> createState() => _InitAppState();
}

class _InitAppState extends ConsumerState<InitApp> {

  init() async {
    await ref.read(loginProvider.notifier).readUser();
    await ref.read(regionProvider.notifier).init();
  }

  @override
  void initState() {
    init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
