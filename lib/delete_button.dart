import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon( Icons.delete,
        color: Theme.of( context ).colorScheme.error,
      ),
    );
  }
}

class DeleteMenuItemButton extends StatelessWidget {
  const DeleteMenuItemButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of( context ) ;
    var style = theme.menuButtonTheme.style?.copyWith(
      foregroundColor: MaterialStatePropertyAll(
        theme.colorScheme.error
      )
    ) ;

    return MenuItemButton(
      onPressed: onPressed,

      style: style,

      leadingIcon: Icon( Icons.delete,
        color: Theme.of( context ).colorScheme.error,
      ),

      child: const Text( 'Delete',
      ),
    );
  }
}

