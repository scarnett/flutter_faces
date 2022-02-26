import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraPhotoButton extends StatefulWidget {
  final double size;

  CameraPhotoButton({
    Key? key,
    this.size = 68.0,
  }) : super(key: key);

  @override
  _CameraPhotoButtonState createState() => _CameraPhotoButtonState();
}

class _CameraPhotoButtonState extends State<CameraPhotoButton> {
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

  void _tapSnapPicture() => print('SNAP!'); // TODO!
}
