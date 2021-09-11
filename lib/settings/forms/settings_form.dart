import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/settings/cubit/cubit.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocListener<SettingsCubit, SettingsState>(
        listener: (
          BuildContext context,
          SettingsState state,
        ) {},
        child: Align(
          alignment: const Alignment(0.0, (-1.0 / 3.0)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [],
            ),
          ),
        ),
      );
}
