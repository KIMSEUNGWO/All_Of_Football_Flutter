

import 'package:all_of_football/component/svg_icon.dart';
import 'package:flutter/material.dart';

class FavoriteIconButtonWidget extends StatefulWidget {

  final int fieldId;
  final bool on;
  final double? size;
  final Function(bool)? onChanged;

  const FavoriteIconButtonWidget({super.key, required this.fieldId, required this.on, this.onChanged, this.size});


  @override
  State<FavoriteIconButtonWidget> createState() => _FavoriteIconButtonWidgetState();
}

class _FavoriteIconButtonWidgetState extends State<FavoriteIconButtonWidget> {

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
