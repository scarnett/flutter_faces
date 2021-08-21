bool isEyeOpen(
  double? eyeOpenProbability, {
  double eyeClosedThreshold: 0.4,
}) {
  bool eyeOpen;

  if (eyeOpenProbability == null) {
    eyeOpen = true;
  } else {
    eyeOpen = (eyeOpenProbability > eyeClosedThreshold);
  }

  return eyeOpen;
}
