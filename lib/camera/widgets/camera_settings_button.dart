import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_faces/camera/widgets/widgets.dart';
import 'package:flutter_faces/settings/views/views.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraSettingsButton extends StatefulWidget {
  CameraSettingsButton({
    Key? key,
  }) : super(key: key);

  @override
  _CameraSettingsButtonState createState() => _CameraSettingsButtonState();
}

class _CameraSettingsButtonState extends State<CameraSettingsButton> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      CameraActionButton(
        onPressed: _onTap,
        icon: Icon(Icons.settings),
        message: AppLocalizations.of(context)!.settings,
      );

  void _onTap() => Navigator.of(context).push(SettingsPage.route());
}
