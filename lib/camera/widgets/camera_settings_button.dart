import 'package:flutter/material.dart';
import 'package:flutter_faces/settings/views/views.dart';

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
      IconButton(
        onPressed: _onTap,
        icon: Icon(Icons.settings),
        iconSize: 30.0,
        padding: const EdgeInsets.all(20.0),
      );

  void _onTap() => Navigator.of(context).push(SettingsPage.route());
}
