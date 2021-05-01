import 'package:flutter/material.dart';
import 'package:flutter_food_quest_animation/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Center(
      child: controller.obx(
        (state) => Container(),
      ),
    );
  }
}
