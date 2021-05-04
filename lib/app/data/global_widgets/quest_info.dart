import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'show_up_animation.dart';

class QuestInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool noAnimation;
  final Color textColor;
  QuestInfo({
    required this.icon,
    required this.title,
    this.noAnimation = false,
    required this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Color(0xff17c37b),
          ),
          const SizedBox(width: 5),
          noAnimation
              ? Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                  ),
                )
              : ShowUpAnimation(
                  delayStart: 100.milliseconds,
                  //offset: widget.isReverse ? -0.2 : 0.2,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
