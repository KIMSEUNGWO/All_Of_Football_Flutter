

import 'package:flutter/material.dart';

class SpaceWidth extends StatelessWidget {

  final double width;

  const SpaceWidth(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width,);
  }
}

class SpaceHeight extends StatelessWidget {

  final double height;

  const SpaceHeight(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height,);
  }
}
