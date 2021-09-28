import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_faces/camera/widgets/widgets.dart';

class CameraOptions extends StatefulWidget {
  CameraOptions({
    Key? key,
  }) : super(key: key);

  @override
  _CameraOptionsState createState() => _CameraOptionsState();
}

class _CameraOptionsState extends State<CameraOptions> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      Container(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 4.0,
            enlargeCenterPage: true,
            viewportFraction: 0.3,
            initialPage: 1,
          ),
          items: [
            CameraSettingsButton(),
            CameraToggleButton(),
            CameraSnapPictureButton(),
            CameraRecordVideoButton(),
          ],
        ),
      );
}
