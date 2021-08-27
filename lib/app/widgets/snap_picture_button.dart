import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_faces/app/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SnapPictureButton extends StatefulWidget {
  SnapPictureButton({
    Key? key,
  }) : super(key: key);

  @override
  _SnapPictureButtonState createState() => _SnapPictureButtonState();
}

class _SnapPictureButtonState extends State<SnapPictureButton> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      ActionButton(
        onPressed: _tapSnapPicture,
        icon: Icon(Icons.photo_camera),
        message: AppLocalizations.of(context)!.snapPicture,
      );

  void _tapSnapPicture() => print('SNAP!'); // TODO!
}
