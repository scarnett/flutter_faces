import 'package:flutter/widgets.dart';
import 'package:flutter_faces/faces/googly_eyes/painters/painters.dart';
import 'package:flutter_faces/faces/googly_eyes/physics/physics.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class GooglyEyes extends StatefulWidget {
  final Face? face;
  final Size imageSize;
  final double maxRadius;
  final double minRadius;
  final double eyeClosedThreshold;

  GooglyEyes({
    Key? key,
    required this.face,
    required this.imageSize,
    this.maxRadius: 60.0,
    this.minRadius: 20.0,
    this.eyeClosedThreshold: 0.4,
  }) : super(key: key);

  @override
  _GooglyEyesState createState() => _GooglyEyesState();
}

class _GooglyEyesState extends State<GooglyEyes> {
  final GooglyEyesPhysics _leftEyePhysics = GooglyEyesPhysics();
  final GooglyEyesPhysics _rightEyePhysics = GooglyEyesPhysics();

  bool _previousIsLeftOpen = true;
  bool _previousIsRightOpen = true;

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
        leftEyeOpen: _isLeftEyeOpen(),
        rightEyePhysics: _rightEyePhysics,
        rightEyeOpen: _isRightEyeOpen(),
      ),
    );
  }

  bool _isLeftEyeOpen() {
    double? leftOpenScore = widget.face!.leftEyeOpenProbability;
    bool leftEyeOpen;

    if (leftOpenScore == null) {
      leftEyeOpen = _previousIsLeftOpen;
    } else {
      leftEyeOpen = (leftOpenScore > widget.eyeClosedThreshold);
      _previousIsLeftOpen = leftEyeOpen;
    }

    return leftEyeOpen;
  }

  bool _isRightEyeOpen() {
    double? rightOpenScore = widget.face!.rightEyeOpenProbability;
    bool rightEyeOpen;

    if (rightOpenScore == null) {
      rightEyeOpen = _previousIsRightOpen;
    } else {
      rightEyeOpen = (rightOpenScore > widget.eyeClosedThreshold);
      _previousIsRightOpen = rightEyeOpen;
    }

    return rightEyeOpen;
  }
}
