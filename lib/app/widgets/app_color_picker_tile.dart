import 'package:flutter/material.dart';
import 'package:flutter_faces/app/widgets/widgets.dart';

class AppColorPickerTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final double paletteSize;
  final EdgeInsets padding;
  final Color color;
  final Function(Color) onSave;

  const AppColorPickerTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.icon,
    this.paletteSize: 20.0,
    this.padding: const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0,
    ),
    required this.color,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      MergeSemantics(
        child: ListTile(
          title: Text(title),
          subtitle: (subtitle == null) ? null : Text(subtitle!),
          leading: (icon == null)
              ? null
              : Icon(
                  icon,
                  color: _getIconColor(),
                ),
          onTap: () => _showColorPicker(context),
          contentPadding: padding,
        ),
      );

  void _showColorPicker(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) =>
          AppColorPicker(
        color: color,
        onSave: onSave,
      ),
    );
  }

  Color _getIconColor() {
    if (color == Colors.white) {
      return Colors.grey;
    }

    return color;
  }
}
