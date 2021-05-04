import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/quest_item.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late bool _isSwipeUp;
  late bool _isSwipeDown;
  late int _currentIndex = 0;
  late Offset _verticalSwipeStartingOffset;
  late AnimationController animationController;
  late AnimationController bgController;
  //late AnimationController clockwiseController;
  //late AnimationController counterClockwiseController;
  late Animation<double> positionAnim;
  //late Animation<Color?> colorAnim;
  late Animation<Offset> _animationSlide;
  late Animation<Color?> textColorAnim;
  late Animation<double> clockwiseAnim;
  late Animation<double> counterClockwiseAnim;
  late Animation<Offset> textSlideUpAnim;
  late Animation<Offset> textSlideDownAnim;
  late Animation<double> fadeAnim;

  late Tween<double> clockwiseTween;
  late Tween<double> counterClockwiseTween;

  //late Animation<double> opacityAnim;
  bool isClockwise = false;
  double rotationValue = 0.0;

  bool canClick = true;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: 500.milliseconds)
      ..addStatusListener((status) {
        setState(() {});
      });

    bgController = AnimationController(vsync: this, duration: 400.milliseconds)
      ..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          Future.delayed(0.seconds, () => animationController.forward());
        } else if (status == AnimationStatus.reverse) {
          Future.delayed(0.seconds, () => animationController.reverse());
        }
        setState(() {});
      });

    positionAnim = Tween(begin: -Get.height, end: 0.0).animate(bgController);

    textColorAnim = ColorTween(begin: Color(0xff333B49), end: Colors.white).animate(bgController);

    clockwiseTween = Tween<double>(begin: 0, end: 2 * math.pi);

    clockwiseAnim = clockwiseTween.animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticOut,
    ));

    counterClockwiseTween = Tween<double>(begin: 0, end: -2 * math.pi);

    counterClockwiseAnim = counterClockwiseTween.animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticOut,
    ))
      ..addListener(() {
        setState(() {
          rotationValue = isClockwise ? clockwiseAnim.value : counterClockwiseAnim.value;
        });
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    bgController.dispose();
    super.dispose();
  }

  void _onSwipeUp(HomeController controller) {
    setState(() {
      isClockwise = true;
      _currentIndex < controller.recipes.length - 1 ? _currentIndex++ : 0;
      bgController.forward();
    });
  }

  void _onSwipeDown() {
    setState(() {
      isClockwise = false;
      _currentIndex > 0 ? _currentIndex-- : 0;
      bgController.reverse();
      counterClockwiseTween.begin = clockwiseTween.end;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    isClockwise = details.localPosition.dy < 0;
    if (_verticalSwipeStartingOffset.dy > details.localPosition.dy) {
      _isSwipeUp = true;
      _isSwipeDown = false;
    } else {
      _isSwipeDown = true;
      _isSwipeUp = false;
    }
  }

  void _onVerticalDragStart(DragStartDetails details) {
    _verticalSwipeStartingOffset = details.localPosition;
  }

  void _onVerticalDragEnd(DragEndDetails details, HomeController controller) {
    rotationValue = 0.0;
    /*counterClockwiseTween.begin = rotationValue;
    clockwiseTween.begin = rotationValue;*/
    if (_isSwipeUp) {
      _onSwipeUp(controller);
    } else if (_isSwipeDown) {
      _onSwipeDown();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AbsorbPointer(
        absorbing: !canClick,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragStart: _onVerticalDragStart,
          onVerticalDragUpdate: _onVerticalDragUpdate,
          onVerticalDragEnd: (details) => _onVerticalDragEnd(details, controller),
          child: Container(
            height: Get.height,
            width: Get.width,
            child: controller.obx(
              (state) => Stack(
                children: [
                  AnimatedPositioned(
                    bottom: positionAnim.value,
                    duration: 300.milliseconds,
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                      height: Get.height,
                      width: Get.width,
                      color: Color(0xff333B49),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(top: 20, left: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_back,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "DAILY COOKING QUEST",
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: QuestItem(
                          item: state![_currentIndex],
                          textColorAnim: textColorAnim,
                          rotationValue: rotationValue,
                          isReverse: isClockwise,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
