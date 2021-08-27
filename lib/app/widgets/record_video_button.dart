import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_faces/app/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecordVideoButton extends StatefulWidget {
  RecordVideoButton({
    Key? key,
  }) : super(key: key);

  @override
  _RecordVideoButtonState createState() => _RecordVideoButtonState();
}

class _RecordVideoButtonState extends State<RecordVideoButton> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      ActionButton(
        onPressed: _tapRecordVideo,
        icon: Icon(Icons.play_arrow),
        message: AppLocalizations.of(context)!.recordVideo,
      );

  void _tapRecordVideo() => print('RECORD!'); // TODO!
}
