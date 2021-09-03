import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_faces/camera/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraSnapPictureButton extends StatefulWidget {
  CameraSnapPictureButton({
    Key? key,
  }) : super(key: key);

  @override
  _CameraSnapPictureButtonState createState() =>
      _CameraSnapPictureButtonState();
}

class _CameraSnapPictureButtonState extends State<CameraSnapPictureButton> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      CameraActionButton(
        onPressed: _tapSnapPicture,
        icon: Icon(Icons.photo_camera),
        message: AppLocalizations.of(context)!.snapPicture,
      );

  void _tapSnapPicture() => print('SNAP!'); // TODO!
}
