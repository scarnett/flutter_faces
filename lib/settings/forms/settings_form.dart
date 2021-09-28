import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/app/widgets/widgets.dart';
import 'package:flutter_faces/settings/cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<SettingsCubit, SettingsState>(
        builder: (
          BuildContext context,
          SettingsState state,
        ) =>
            SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSectionHeader(text: AppLocalizations.of(context)!.faces),
              AppCheckboxTile(
                title: AppLocalizations.of(context)!.googlyEyes,
                subtitle: AppLocalizations.of(context)!.googlyEyesHint,
                icon: Icons.radio_button_checked,
                checked: context.read<SettingsCubit>().state.googlyEyes,
                onTap: (bool? status) => _tapGooglyEyes(context, status),
              ),
              Divider(),
              if (context.read<SettingsCubit>().state.googlyEyes)
                AppCheckboxTile(
                  title: AppLocalizations.of(context)!.blinkDetection,
                  subtitle: AppLocalizations.of(context)!.blinkDetectionHint,
                  icon: Icons.visibility,
                  checked: context.read<SettingsCubit>().state.blinkDetection,
                  onTap: (bool? status) => _tapBlinkDetection(context, status),
                ),
              if (context.read<SettingsCubit>().state.googlyEyes) Divider(),
              AppCheckboxTile(
                title: AppLocalizations.of(context)!.faceBorder,
                subtitle: AppLocalizations.of(context)!.faceBorderHint,
                icon: Icons.face,
                checked: context.read<SettingsCubit>().state.faceBorder,
                onTap: (bool? status) => _tapFaceBorder(context, status),
              ),
              Divider(),
            ],
          ),
        ),
      );

  void _tapGooglyEyes(
    BuildContext context,
    bool? status,
  ) =>
      context.read<SettingsCubit>().googlyEyesChanged(status!);

  void _tapBlinkDetection(
    BuildContext context,
    bool? status,
  ) =>
      context.read<SettingsCubit>().blinkDetectionChanged(status!);

  void _tapFaceBorder(
    BuildContext context,
    bool? status,
  ) =>
      context.read<SettingsCubit>().faceBorderChanged(status!);
}
