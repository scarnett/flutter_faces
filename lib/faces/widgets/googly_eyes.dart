import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_faces/faces/faces.dart';
import 'package:flutter_faces/faces/painters/painters.dart';
import 'package:flutter_faces/faces/physics/physics.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class GooglyEyes extends StatefulWidget {
  final Face? face;
  final Size imageSize;
  final double maxRadius;
  final double minRadius;
  final double eyeClosedThreshold;
  final CameraLensDirection cameraLensDirection;

  GooglyEyes({
    Key? key,
    required this.face,
    required this.imageSize,
    this.maxRadius: 60.0,
    this.minRadius: 10.0,
    this.eyeClosedThreshold: 0.4,
    this.cameraLensDirection: CameraLensDirection.front,
  }) : super(key: key);

  @override
  _GooglyEyesState createState() => _GooglyEyesState();
}

class _GooglyEyesState extends State<GooglyEyes> {
  final GooglyEyesPhysics _leftEyePhysics = GooglyEyesPhysics();
  final GooglyEyesPhysics _rightEyePhysics = GooglyEyesPhysics();

  @override
  Widget build(
    BuildContext context,
  ) {
    if (widget.face == null) {
      return Container();
    }

    return CustomPaint(
      painter: GooglyEyesPainter(
        face: widget.face!,
        imageSize: widget.imageSize,
        maxRadius: widget.maxRadius,
        minRadius: widget.minRadius,
        leftEyePhysics: _leftEyePhysics,
        leftEyeOpen: isEyeOpen(
          widget.face!.leftEyeOpenProbability,
          eyeClosedThreshold: widget.eyeClosedThreshold,
        ),
        rightEyePhysics: _rightEyePhysics,
        rightEyeOpen: isEyeOpen(
          widget.face!.rightEyeOpenProbability,
          eyeClosedThreshold: widget.eyeClosedThreshold,
        ),
        cameraLensDirection: widget.cameraLensDirection,
      ),
    );
  }
}
