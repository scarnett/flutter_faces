import 'package:flutter/material.dart';
import 'package:flutter_faces/camera/widgets/widgets.dart';

class CameraOptionButtons extends StatefulWidget {
  CameraOptionButtons({
    Key? key,
  }) : super(key: key);

  @override
  _CameraOptionButtonsState createState() => _CameraOptionButtonsState();
}

class _CameraOptionButtonsState extends State<CameraOptionButtons> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      Container(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CameraImageButton(),
            CameraPhotoButton(),
            CameraToggleButton(),
          ],
        ),
      );
}
