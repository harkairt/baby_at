import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

class GradientDebugContainer extends StatelessWidget {
  const GradientDebugContainer({
    required this.child,
    required this.debugChild,
    super.key,
  });

  final Widget child;
  final Widget debugChild;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return OutlineGradientButton(
        gradient: SweepGradient(
          colors: List.generate(360, (h) => HSLColor.fromAHSL(1, h.toDouble(), 1, 0.5).toColor()),
        ),
        strokeWidth: 1,
        radius: const Radius.circular(8),
        child: debugChild,
      );
    }

    return child;
  }
}
