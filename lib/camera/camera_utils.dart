import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

Widget buildCameraOrientationBox({
  required BuildContext context,
  required CameraController controller,
  required List<Widget> children,
}) {
  final MediaQueryData mqData = MediaQuery.of(context);
  final Orientation orientation = mqData.orientation;
  final double width = mqData.size.width;
  final double height = mqData.size.width;
  final Widget widget;

  switch (orientation) {
    case Orientation.landscape:
      widget = FittedBox(
        fit: BoxFit.fitWidth,
        child: Container(
          width: (height * controller.value.aspectRatio),
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: children,
          ),
        ),
      );

      break;

    case Orientation.portrait:
    default:
      widget = FittedBox(
        fit: BoxFit.fitHeight,
        child: Container(
          width: width,
          height: (width * controller.value.aspectRatio),
          child: Stack(
            fit: StackFit.expand,
            children: children,
          ),
        ),
      );

      break;
  }

  return Transform.scale(
    scale: 1.0,
    child: AspectRatio(
      aspectRatio: mqData.size.aspectRatio,
      child: OverflowBox(
        alignment: Alignment.center,
        child: widget,
      ),
    ),
  );
}
