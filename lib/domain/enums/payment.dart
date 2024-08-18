
import 'package:all_of_football/component/svg_icon.dart';
import 'package:flutter/material.dart';

enum Payment {

  LINE(Color(0xFF08BF5B)),
  KAKAO(Color(0xFFF3DA01)),
  APPLE(Colors.black);

  final Color backgroundColor;

  const Payment(this.backgroundColor);

  SIcon getLogo() {
    return switch (this) {
      Payment.LINE => SIcon.linePay,
      Payment.KAKAO => SIcon.kakaoPay,
      Payment.APPLE => SIcon.applePay,
    };
  }
}