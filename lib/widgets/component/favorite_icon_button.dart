

import 'package:all_of_football/component/svg_icon.dart';
import 'package:all_of_football/notifier/user_notifier.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteIconButtonWidget extends ConsumerStatefulWidget {

  final int fieldId;
  final bool on;
  final double? size;
  final Function(bool)? onChanged;

  const FavoriteIconButtonWidget({super.key, required this.fieldId, required this.on, this.onChanged, this.size});


  @override
  ConsumerState<FavoriteIconButtonWidget> createState() => _FavoriteIconButtonWidgetState();
}

class _FavoriteIconButtonWidgetState extends ConsumerState<FavoriteIconButtonWidget> {

  bool _isOn = false;

  _fetch() async {

  }

  _toggle() {
    setState(() => _isOn = !_isOn);
    if (widget.onChanged != null) {
      widget.onChanged!(_isOn);
    }
    _fetch();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _isOn = widget.on;
      });
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool hasLogin = ref.read(loginProvider.notifier).has();
    if (!hasLogin) return const SizedBox();
    return GestureDetector(
      onTap: _toggle,
      child: SvgIcon.asset(
        sIcon: _isOn ? SIcon.bookmarkFill : SIcon.bookmark,
        style: SvgIconStyle(
          height: widget.size, width: widget.size
        )
      ),
    );
  }
}
