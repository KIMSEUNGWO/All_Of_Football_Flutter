
import 'package:all_of_football/component/svg_icon.dart';
import 'package:flutter/material.dart';

class UserProfileWidget extends StatelessWidget {

  final double diameter;
  final Image? image;

  const UserProfileWidget({super.key, required this.diameter, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter, height: diameter,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: image ??
        Center(
          child: SvgIcon.asset(sIcon: SIcon.personFill,
            style: SvgIconStyle(
              width: diameter * 0.6,
              height: diameter * 0.6,
              color: Colors.white
            )
          ),
        ),
    );
  }
}
