
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {

  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  BoxConstraints? constraints;
  EdgeInsets? padding;
  BorderRadius? radius;

  CustomContainer({super.key, this.width, this.height, this.margin, this.radius, this.child, this.padding, this.constraints});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(15),
      width: width,
      height: height,
      margin: margin,
      constraints: constraints,
      decoration: BoxDecoration(
        borderRadius: radius ?? BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, 2),
            blurRadius: 4
          )
        ]
      ),
      child: child,
    );
  }
}
