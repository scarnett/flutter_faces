import 'package:flutter/widgets.dart';
import 'package:flutter_faces/faces/painters/painters.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceBorder extends StatefulWidget {
  final Face? face;
  final Size imageSize;

  FaceBorder({
    Key? key,
    required this.face,
    required this.imageSize,
  }) : super(key: key);

  @override
  _FaceBorderState createState() => _FaceBorderState();
}

class _FaceBorderState extends State<FaceBorder> {
  @override
  Widget build(
    BuildContext context,
  ) {
    if (widget.face == null) {
      return Container();
    }

    return CustomPaint(
      painter: FaceBorderPainter(
        face: widget.face!,
        imageSize: widget.imageSize,
      ),
    );
  }
}
