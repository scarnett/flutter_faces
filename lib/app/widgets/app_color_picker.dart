import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AppColorPicker extends StatelessWidget {
  final Color color;
  final Function(Color)? onSave;

  AppColorPicker({
    Key? key,
    required this.color,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      AlertDialog(
        titlePadding: const EdgeInsets.all(0.0),
        contentPadding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        content: SingleChildScrollView(
          child: SlidePicker(
            pickerColor: color,
            onColorChanged: (onSave == null) ? (Color color) => {} : onSave!,
            paletteType: PaletteType.rgb,
            enableAlpha: false,
            displayThumbColor: true,
            showLabel: false,
            showIndicator: true,
            indicatorBorderRadius: const BorderRadius.vertical(
              top: const Radius.circular(25.0),
            ),
          ),
        ),
      );
}
