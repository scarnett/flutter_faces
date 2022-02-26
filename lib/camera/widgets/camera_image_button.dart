import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraImageButton extends StatefulWidget {
  final double size;

  CameraImageButton({
    Key? key,
    this.size = 68.0,
  }) : super(key: key);

  @override
  _CameraImageButtonState createState() => _CameraImageButtonState();
}

class _CameraImageButtonState extends State<CameraImageButton> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      Tooltip(
        preferBelow: false,
        verticalOffset: 30.0,
        message: AppLocalizations.of(context)!.photo,
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          elevation: 0.0,
          child: Container(
            width: widget.size,
            height: widget.size,
          ),
        ),
      );
}
