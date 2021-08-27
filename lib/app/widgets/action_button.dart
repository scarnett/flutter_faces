import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final String message;

  const ActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final ThemeData theme = Theme.of(context);

    return Tooltip(
      preferBelow: false,
      verticalOffset: 30.0,
      message: message,
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: theme.accentColor,
        elevation: 4.0,
        child: IconTheme.merge(
          data: theme.accentIconTheme,
          child: IconButton(
            onPressed: onPressed,
            icon: icon,
          ),
        ),
      ),
    );
  }
}
