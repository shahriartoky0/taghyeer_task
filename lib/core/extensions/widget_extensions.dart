import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget get centered => Center(child: this);
  Widget get expanded => Expanded(child: this);

  Widget visible(bool isVisible) => isVisible ? this : const SizedBox.shrink();

  Widget withPadding(EdgeInsetsGeometry padding) => Padding(padding: padding, child: this);

  Widget withMargin(EdgeInsetsGeometry margin) => Container(margin: margin, child: this);

  Widget withAlign(Alignment alignment) => Align(alignment: alignment, child: this);

  Widget withRoundedCorners({double radius = 8.0}) => ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: this,
  );
}