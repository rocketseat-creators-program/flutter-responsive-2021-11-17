import 'package:flutter/material.dart';

import 'break_points.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveWidget({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  Widget _getWidget(BoxConstraints dimensoes) {
    if (dimensoes.maxWidth < BreakPoints.mobile) {
      return mobile;
    }
    if (dimensoes.maxWidth > BreakPoints.mobile &&
        dimensoes.maxWidth <= BreakPoints.tablet) {
      return tablet;
    }

    if (dimensoes.maxWidth > BreakPoints.tablet &&
        dimensoes.maxWidth <= BreakPoints.desktop) {
      return desktop;
    }

    return Center(
      child: SizedBox(
        width: BreakPoints.desktop,
        child: desktop,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimensoes) {
      return AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        duration: const Duration(seconds: 1),
        child: _getWidget(dimensoes),
      );
    });
  }
}
