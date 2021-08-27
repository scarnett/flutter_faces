import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_faces/app/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsButton extends StatefulWidget {
  SettingsButton({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsButtonState createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      ActionButton(
        onPressed: _tapSettings,
        icon: Icon(Icons.settings),
        message: AppLocalizations.of(context)!.settings,
      );

  void _tapSettings() => print('SETTINGS!'); // TODO!
}
