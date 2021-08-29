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
  ) =>
      Tooltip(
        preferBelow: false,
        verticalOffset: 30.0,
        message: message,
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: Theme.of(context).accentColor.withOpacity(0.5),
          elevation: 0.0,
          child: IconTheme.merge(
            data: Theme.of(context).accentIconTheme,
            child: IconButton(
              onPressed: onPressed,
              icon: icon,
              iconSize: 30.0,
              padding: const EdgeInsets.all(20.0),
            ),
          ),
        ),
      );
}
