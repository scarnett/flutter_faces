import 'package:flutter/widgets.dart';
import 'package:flutter_faces/app/app.dart';
import 'package:flutter_faces/camera/camera.dart';
import 'package:flutter_faces/login/views/views.dart';

List<Page> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [CameraView.page()];

    case AppStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
