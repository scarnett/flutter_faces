import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/camera/bloc/bloc.dart';
import 'package:flutter_faces/camera/widgets/widgets.dart';
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
      CameraActionButton(
        onPressed: _tapToggleCamera,
        icon: Icon(_getIcon()),
        message: AppLocalizations.of(context)!.toggleCameraDirection,
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
