import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/app/bloc/bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraToggle extends StatefulWidget {
  CameraToggle({
    Key? key,
  }) : super(key: key);

  @override
  _CameraToggleState createState() => _CameraToggleState();
}

class _CameraToggleState extends State<CameraToggle> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      Tooltip(
        message: AppLocalizations.of(context)!.toggleCameraDirection,
        child: FloatingActionButton(
          onPressed: _tapToggleCamera,
          child: Icon(_getIcon()),
        ),
      );

  IconData _getIcon() {
    if (context.read<AppBloc>().state.cameraLensDirection ==
        CameraLensDirection.front) {
      return Icons.camera_front;
    }

    return Icons.camera_rear;
  }

  void _tapToggleCamera() =>
      context.read<AppBloc>().add(ToggleCameraLensDirection());
}
