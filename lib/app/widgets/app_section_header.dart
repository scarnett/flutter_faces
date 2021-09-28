import 'package:flutter/material.dart';

class AppSectionHeader extends StatelessWidget {
  final String text;
  final EdgeInsets padding;
  final TextStyle? style;

  AppSectionHeader({
    required this.text,
    this.padding: const EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 8.0,
    ),
    this.style,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      Container(
        alignment: Alignment.centerLeft,
        padding: padding,
        child: Text(
          text.toUpperCase(),
          style: (style == null) ? Theme.of(context).textTheme.headline6 : null,
        ),
      );
}
