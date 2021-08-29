import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class ExpandingActionButton extends StatelessWidget {
  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  const ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      AnimatedBuilder(
        animation: progress,
        builder: (
          BuildContext context,
          Widget? child,
        ) {
          final offset = Offset.fromDirection(
            (directionInDegrees * (math.pi / 180.0)),
            (progress.value * maxDistance),
          );

          return Positioned(
            right: (4.0 + offset.dx),
            bottom: (4.0 + offset.dy),
            child: Transform.rotate(
              angle: ((1.0 - progress.value) * math.pi / 2.0),
              child: child!,
            ),
          );
        },
        child: FadeTransition(
          opacity: progress,
          child: child,
        ),
      );
}
