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
                checked: state.googlyEyes,
                onTap: (bool? status) => _tapGooglyEyes(context, status),
              ),
              Divider(),
              AppCheckboxTile(
                title: AppLocalizations.of(context)!.blinkDetection,
                subtitle: AppLocalizations.of(context)!.blinkDetectionHint,
                icon: Icons.visibility,
                checked: state.blinkDetection,
                onTap: state.googlyEyes
                    ? (bool? status) => _tapBlinkDetection(context, status)
                    : null,
              ),
              Divider(),
              AppColorPickerTile(
                title: AppLocalizations.of(context)!.eyeColor,
                subtitle: AppLocalizations.of(context)!.eyeColorHint,
                icon: Icons.palette,
                color: state.eyeColor,
                onSave: (Color color) => _saveEyeColor(context, color),
              ),
              Divider(),
              AppColorPickerTile(
                title: AppLocalizations.of(context)!.eyeLidColor,
                subtitle: AppLocalizations.of(context)!.eyeLidColorHint,
                icon: Icons.palette,
                color: state.eyeLidColor,
                onSave: (Color color) => _saveEyeLidColor(context, color),
              ),
              Divider(),
              AppColorPickerTile(
                title: AppLocalizations.of(context)!.eyeOutlineColor,
                subtitle: AppLocalizations.of(context)!.eyeOutlineColorHint,
                icon: Icons.palette,
                color: state.eyeOutlineColor,
                onSave: (Color color) => _saveEyeOutlineColor(context, color),
              ),
              Divider(),
              AppColorPickerTile(
                title: AppLocalizations.of(context)!.eyeIrisColor,
                subtitle: AppLocalizations.of(context)!.eyeIrisColorHint,
                icon: Icons.palette,
                color: state.eyeIrisColor,
                onSave: (Color color) => _saveEyeIrisColor(context, color),
              ),
              Divider(),
              AppCheckboxTile(
                title: AppLocalizations.of(context)!.faceBorder,
                subtitle: AppLocalizations.of(context)!.faceBorderHint,
                icon: Icons.face,
                checked: state.faceBorder,
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

  void _saveEyeColor(
    BuildContext context,
    Color color,
  ) =>
      context.read<SettingsCubit>().eyeColorChanged(color);

  void _saveEyeLidColor(
    BuildContext context,
    Color color,
  ) =>
      context.read<SettingsCubit>().eyeLidColorChanged(color);

  void _saveEyeOutlineColor(
    BuildContext context,
    Color color,
  ) =>
      context.read<SettingsCubit>().eyeOutlineColorChanged(color);

  void _saveEyeIrisColor(
    BuildContext context,
    Color color,
  ) =>
      context.read<SettingsCubit>().eyeIrisColorChanged(color);

  void _tapFaceBorder(
    BuildContext context,
    bool? status,
  ) =>
      context.read<SettingsCubit>().faceBorderChanged(status!);
}
