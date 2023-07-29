import 'package:flutter/material.dart';

class HeroDialogRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  HeroDialogRoute({
    required this.builder,
    required RouteSettings settings,
  }) : super(fullscreenDialog: false, settings: settings);

  @override
  // TODO: implement barrierColor
  Color? get barrierColor => Colors.black54;

  @override
  // TODO: implement barrierLabel
  String? get barrierLabel => "Popup dialog open";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: secondaryAnimation,
      child: child,
    );
  }

  @override
  // TODO: implement maintainState
  bool get opaque => false;

  @override
  // TODO: implement maintainState
  bool get barrierDismissible => true;

  @override
  // TODO: implement maintainState
  bool get maintainState => true;

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
