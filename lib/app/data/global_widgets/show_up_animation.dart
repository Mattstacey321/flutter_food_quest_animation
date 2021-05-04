import 'dart:async';

import 'package:flutter/material.dart';

class ShowUpAnimation extends StatefulWidget {
  /// The child on which to apply the given [ShowUpAnimation].
  final Widget child;

  /// The offset by which to slide and [child] into view from [Direction].
  /// Use negative value to reverse animation [direction]. Defaults to 0.2.
  final double offset;

  /// The curve used to animate the [child] into view.
  /// Defaults to [Curves.easeIn]
  final Curve curve;

  /// The delay with which to animate the [child]. Takes in a [Duration] and
  /// defaults to 0.0 seconds.
  final Duration delayStart;

  /// The total duration in which the animation completes. Defaults to 200 milliseconds.
  final Duration animationDuration;

  ShowUpAnimation({
    required this.child,
    this.offset = 0.2,
    this.curve = Curves.easeIn,
    this.delayStart = const Duration(seconds: 0),
    this.animationDuration = const Duration(milliseconds: 200),
    Key? key,
  }) : super(key: key);

  @override
  _ShowUpAnimationState createState() => _ShowUpAnimationState();
}

class _ShowUpAnimationState extends State<ShowUpAnimation> with SingleTickerProviderStateMixin {
  late Animation<Offset> _animationSlide;

  AnimationController? _animationController;

  late Animation<double> _animationFade;

  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    if (_isDisposed) {
      return;
    } else {
      _animationController = AnimationController(
        vsync: this,
        duration: widget.animationDuration,
      );

      _animationSlide =
          Tween<Offset>(begin: Offset(0, widget.offset), end: Offset(0, 0)).animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController!,
      ));

      _animationFade = Tween<double>(begin: -1.0, end: 1.0).animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController!,
      ));

      Timer(widget.delayStart, () {
        if (_animationController != null && !_isDisposed) _animationController!.forward();
      });
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationFade,
      child: SlideTransition(
        position: _animationSlide,
        child: widget.child,
      ),
    );
  }
}
