import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_faces/camera/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraRecordVideoButton extends StatefulWidget {
  CameraRecordVideoButton({
    Key? key,
  }) : super(key: key);

  @override
  _CameraRecordVideoButtonState createState() =>
      _CameraRecordVideoButtonState();
}

class _CameraRecordVideoButtonState extends State<CameraRecordVideoButton> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      CameraActionButton(
        onPressed: _tapRecordVideo,
        icon: Icon(Icons.play_arrow),
        message: AppLocalizations.of(context)!.recordVideo,
      );

  void _tapRecordVideo() => print('RECORD!'); // TODO!
}
