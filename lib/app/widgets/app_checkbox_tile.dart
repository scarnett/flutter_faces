import 'package:flutter/material.dart';

class AppCheckboxTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final bool checked;
  final ListTileControlAffinity affinity;
  final EdgeInsets padding;
  final Function(bool?)? onTap;

  const AppCheckboxTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.checked,
    this.affinity: ListTileControlAffinity.trailing,
    this.padding: const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 16.0,
    ),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      Opacity(
        opacity: (onTap == null) ? 0.3 : 1.0,
        child: CheckboxListTile(
          title: Text(title),
          subtitle: (subtitle == null) ? null : Text(subtitle!),
          secondary: (icon == null) ? null : Icon(icon),
          value: checked,
          onChanged: onTap,
          controlAffinity: affinity,
          contentPadding: padding,
        ),
      );
}
