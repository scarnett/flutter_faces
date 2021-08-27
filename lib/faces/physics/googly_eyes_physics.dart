import 'dart:math' as math;

import 'package:flutter/widgets.dart';

// @see https://github.com/googlesamples/android-vision/blob/master/visionSamples/googly-eyes/app/src/main/java/com/google/android/gms/samples/vision/face/googlyeyes/EyePhysics.java
class GooglyEyesPhysics {
  // The friction and gravity values below are set relative to a specific time
  // period. This allows the simulation to run at the same rate, regardless
  // of whether it is running on a slow or fast device or if there are temporary
  // performance variations on the device.
  int _timePeriodMs = 1000;

  double _friction = 2.2;
  double _gravity = 40.0;
  double _bounceMultiplier = 20.0;

  // Allow slightly non-zero values to be considered to be zero, to converge
  // to zero more quickly.
  double _zeroTolerance = 0.001;

  int _lastUpdateTime = DateTime.now().millisecondsSinceEpoch;

  Offset? _eyePosition;
  double? _eyeRadius;

  Offset? _irisPosition;
  double? _irisRadius;

  // Velocity is independent of the final rendering coordinate system, so that
  // we don't have to change it as the eye gets bigger or smaller by forward
  // and backward motion. This will be scaled up proportional to the eye size
  // when updating position.
  double _vx = 0.0;
  double _vy = 0.0;

  // Keep track of bounces that immediately occur consecutively, since this
  // means that the iris is bouncing too fast.  When this happens, we dampen
  // the velocity to avoid infinite bounces.
  int _consecutiveBounces = 0;

  /// Generate the next position of the iris based on simulated velocity,
  /// eye boundaries, gravity, friction, and bounce momentum.
  Offset nextIrisPosition(
    Offset eyePosition,
    double eyeRadius,
    double irisRadius,
  ) {
    // Correct the current eye position and size based on recent motion of the
    // face within the frame. Keep the current iris position, if available.
    _eyePosition = eyePosition;
    _eyeRadius = eyeRadius;

    if (_irisPosition == null) {
      _irisPosition = _eyePosition;
    }

    _irisRadius = irisRadius;

    // Keep track of time, so that we can consistently update the simulation
    // proportionally to how much time has elapsed. This makes the animation
    // rate device-independent. All of the velocity changes below are pro-rated
    // based on this.
    int now = DateTime.now().millisecondsSinceEpoch;
    int elapsedTimeMs = (now - _lastUpdateTime);
    double simulationRate = (elapsedTimeMs / _timePeriodMs);
    _lastUpdateTime = now;

    if (!_isStopped()) {
      // Only apply gravity when the iris is not stopped at the bottom of
      // the eye.
      _vy += (_gravity * simulationRate);
    }

    // Apply friction in the opposite direction of motion, so that the iris
    // slows in the absence of other head motion.
    _vx = _applyFriction(_vx, simulationRate);
    _vy = _applyFriction(_vy, simulationRate);

    // Update the iris position based on velocity. Since velocity is
    // size-independent, scale by the iris radius to get the change in position.
    double x = (_irisPosition!.dx + (_vx * _irisRadius! * simulationRate));
    double y = (_irisPosition!.dy + (_vy * _irisRadius! * simulationRate));
    _irisPosition = Offset(x, y);

    // Correct the position and velocity of the iris if it has gone out of
    // bounds, guaranteeing that the returned result is at a valid position
    // within the eye.
    _makeIrisInBounds(simulationRate);

    return _irisPosition!;
  }

  /// Friction slows velocity in the opposite direction of motion, until zero
  /// velocity is reached.
  double _applyFriction(
    double velocity,
    double simulationRate,
  ) {
    if (_isZero(velocity)) {
      velocity = 0.0;
    } else if (velocity > 0.0) {
      velocity = math.max(0.0, (velocity - (_friction * simulationRate)));
    } else {
      velocity = math.min(0.0, (velocity + (_friction * simulationRate)));
    }

    return velocity;
  }

  /// Correct the iris position to be in-bounds within the eye, if it is now
  /// out of bounds.  Being out of bounds could have been due to a sudden
  /// movement of the head and/or camera, or then result of just
  /// bouncing/rolling around.
  ///
  /// In addition, modify the velocity to cause a bounce in the
  /// opposite direction.
  void _makeIrisInBounds(
    double simulationRate,
  ) {
    num irisOffsetX = (_irisPosition!.dx - _eyePosition!.dx);
    num irisOffsetY = (_irisPosition!.dy - _eyePosition!.dy);

    double maxDistance = (_eyeRadius! - _irisRadius!);
    double distance =
        math.sqrt(math.pow(irisOffsetX, 2) + math.pow(irisOffsetY, 2));

    if (distance <= maxDistance) {
      // The iris is in bounds, so no correction is necessary.
      _consecutiveBounces = 0;
      return;
    }

    // Accumulate a consecutive bounce count, in order to dampen the momentum
    // of a quickly moving iris. Two or more bounces in a row indicates that
    // the iris is moving so fast that it doesn't even travel inside the eye.
    // We progressively slow the velocity using this count until this is no
    // longer the case.
    _consecutiveBounces++;

    // Move the iris back to where it would have been when it would have
    // contacted the side of the eye.
    double ratio = (maxDistance / distance);
    double x = (_eyePosition!.dx + (ratio * irisOffsetX));
    double y = (_eyePosition!.dy + (ratio * irisOffsetY));

    // Update the velocity direction and magnitude to cause a bounce.
    double dx = (x - _irisPosition!.dx);
    _vx = (_applyBounce(_vx, dx, simulationRate) / _consecutiveBounces);

    double dy = (y - _irisPosition!.dy);
    _vy = (_applyBounce(_vy, dy, simulationRate) / _consecutiveBounces);
    _irisPosition = Offset(x, y);
  }

  /// Update velocity in response to bouncing off the sides of the eye
  /// (i.e., when iris hits the bottom or the eye moves quickly). This is the
  /// only way to gain horizontal velocity, since there is no other
  /// horizontal force.
  double _applyBounce(
    double velocity,
    double distOutOfBounds,
    double simulationRate,
  ) {
    if (_isZero(distOutOfBounds)) {
      // No bounce needed, since we are still in bounds along this dimension.
      return velocity;
    }

    // Reverse velocity to create a bounce in the opposite direction.
    velocity *= -1.0;

    // If distOutOfBounds was large, this indicates that the iris was whacked
    // against the side of the eye quickly. Add an additional velocity factor
    // to account for the force gained by this quick movement, based upon how
    // much it was out of bounds.
    double bounce =
        (_bounceMultiplier * (distOutOfBounds / _irisRadius!).abs());

    if (velocity > 0.0) {
      velocity += (bounce * simulationRate);
    } else {
      velocity -= (bounce * simulationRate);
    }

    return velocity;
  }

  /// The iris is stopped if it is at the bottom of the eye and its velocity
  /// is zero.
  bool _isStopped() {
    if (_eyePosition!.dy >= _irisPosition!.dy) {
      return false;
    }

    num irisOffsetY = (_irisPosition!.dy - _eyePosition!.dy);
    double maxDistance = (_eyeRadius! - _irisRadius!);
    if (irisOffsetY < maxDistance) {
      return false;
    }

    return (_isZero(_vx) && _isZero(_vy));
  }

  /// Allow for a small tolerance in floating point values in considering
  /// whether a value is zero.
  bool _isZero(
    double num,
  ) =>
      ((num < _zeroTolerance) && (num > (-1.0 * _zeroTolerance)));
}
