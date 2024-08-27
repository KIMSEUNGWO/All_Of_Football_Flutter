import 'package:all_of_football/component/svg_icon.dart';
import 'package:all_of_football/domain/field/field_simp.dart';
import 'package:all_of_football/notifier/favorite_notifier.dart';
import 'package:all_of_football/notifier/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteIconButtonWidget extends ConsumerWidget {
  final FieldSimp fieldSimp;
  final double? size;
  final bool disabled;

  const FavoriteIconButtonWidget({super.key, required this.fieldSimp, this.size, this.disabled = false});

  bool _has(List<FieldSimp> state, int fieldId) {
    for (var fieldSimp in state) {
      if (fieldSimp.fieldId == fieldId) return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool hasLogin = ref.watch(loginProvider.notifier).has();
    if (!hasLogin) return const SizedBox();

    List<FieldSimp> state = ref.watch(favoriteNotifier);
    bool isOn = _has(state, fieldSimp.fieldId);

    return (!isOn && disabled)
      ? const SizedBox()
      : GestureDetector(
          onTap: () async {
            await ref.read(favoriteNotifier.notifier).toggle(fieldSimp);
          },
          child: SvgIcon.asset(
            sIcon: isOn ? SIcon.bookmarkFill : SIcon.bookmark,
            style: SvgIconStyle(
              height: size,
              width: size,
            ),
          ),
        );
  }
}
