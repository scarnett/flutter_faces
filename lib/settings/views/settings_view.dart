import 'package:flutter/material.dart';
import 'package:flutter_faces/app/widgets/widgets.dart';
import 'package:flutter_faces/settings/forms/forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  static Route route() => AppRouteTransition(page: const SettingsPage());

  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
        body: const SettingsForm(),
      );
}
