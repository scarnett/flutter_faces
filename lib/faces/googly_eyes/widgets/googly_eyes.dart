import 'package:flutter/widgets.dart';
import 'package:flutter_faces/faces/googly_eyes/painters/painters.dart';
import 'package:flutter_faces/faces/googly_eyes/physics/physics.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class GooglyEyes extends StatefulWidget {
  final Face? face;
  final Size imageSize;
  final double maxRadius;
  final double minRadius;

  GooglyEyes({
    Key? key,
    required this.face,
    required this.imageSize,
    this.maxRadius: 60.0,
    this.minRadius: 20.0,
  }) : super(key: key);

  @override
  _GooglyEyesState createState() => _GooglyEyesState();
}

class _GooglyEyesState extends State<GooglyEyes> {
  final GooglyEyesPhysics leftEyePhysics = GooglyEyesPhysics();
  final GooglyEyesPhysics rightEyePhysics = GooglyEyesPhysics();

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
        leftEyePhysics: leftEyePhysics,
        rightEyePhysics: rightEyePhysics,
      ),
    );
  }
}
