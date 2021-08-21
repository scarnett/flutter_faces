import 'package:flutter_faces/faces/googly_eyes/googly_eyes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Eye should be open', () {
    expect(isEyeOpen(1.0), true);
    expect(isEyeOpen(0.5), true);
    expect(isEyeOpen(0.6, eyeClosedThreshold: 0.5), true);
  });

  test('Eye should NOT be open', () {
    expect(isEyeOpen(0.4), false);
    expect(isEyeOpen(0.1), false);
    expect(isEyeOpen(0.5, eyeClosedThreshold: 0.5), false);
  });
}
