import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';

class AppFormContainer extends StatelessWidget {
  const AppFormContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(AppThemeDimensions.formPadding),
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: BorderRadius.circular(AppThemeDimensions.controlRadius),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: colorScheme.onSecondary),
        child: child,
      ),
    );
  }
}
