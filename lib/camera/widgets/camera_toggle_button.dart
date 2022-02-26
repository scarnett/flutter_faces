import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/camera/bloc/bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraToggleButton extends StatefulWidget {
  CameraToggleButton({
    Key? key,
  }) : super(key: key);

  @override
  _CameraToggleButtonState createState() => _CameraToggleButtonState();
}

class _CameraToggleButtonState extends State<CameraToggleButton> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      Tooltip(
        preferBelow: false,
        verticalOffset: 30.0,
        message: AppLocalizations.of(context)!.toggleCameraDirection,
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          elevation: 0.0,
          child: IconTheme.merge(
            data: Theme.of(context).iconTheme,
            child: IconButton(
              onPressed: _tapToggleCamera,
              icon: Icon(_getIcon()),
              iconSize: 30.0,
              padding: const EdgeInsets.all(20.0),
            ),
          ),
        ),
      );

  IconData _getIcon() {
    if (context.read<CameraBloc>().state.cameraLensDirection ==
        CameraLensDirection.front) {
      return Icons.camera_front;
    }

    return Icons.camera_rear;
  }

  void _tapToggleCamera() =>
      context.read<CameraBloc>().add(ToggleCameraLensDirection());
}
