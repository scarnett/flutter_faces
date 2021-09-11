import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/app/widgets/app_transparent_route.dart';
import 'package:flutter_faces/settings/cubit/cubit.dart';
import 'package:flutter_faces/settings/forms/forms.dart';

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
        appBar: AppBar(title: const Text('Settings')), // TODO! i10n
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (_) => SettingsCubit(),
            child: const SettingsForm(),
          ),
        ),
      );
}
