import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_faces/faces/painters/painters.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceBorder extends StatefulWidget {
  final Face face;
  final Size imageSize;
  final CameraLensDirection cameraLensDirection;
  final Color faceBorderColor;
  final Color faceBorderErrorColor;

  FaceBorder({
    Key? key,
    required this.face,
    required this.imageSize,
    this.cameraLensDirection: CameraLensDirection.front,
    required this.faceBorderColor,
    required this.faceBorderErrorColor,
  }) : super(key: key);

  @override
  _FaceBorderState createState() => _FaceBorderState();
}

class _FaceBorderState extends State<FaceBorder> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      CustomPaint(
        painter: FaceBorderPainter(
          face: widget.face,
          imageSize: widget.imageSize,
          cameraLensDirection: widget.cameraLensDirection,
          faceBorderColor: widget.faceBorderColor,
          faceBorderErrorColor: widget.faceBorderErrorColor,
        ),
      );
}
