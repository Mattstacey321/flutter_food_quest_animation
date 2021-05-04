import 'package:flutter/material.dart';
import '../controllers/recipe_detail_controller.dart';
import 'package:get/get.dart';

class CustomTabBar extends GetView<RecipeDetailController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
        ),
      ),
      child: SizedBox(
        width: Get.width / 2,
        child: Stack(
          children: [
            Theme(
              data: ThemeData(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              child: TabBar(
                controller: controller.tabController,
                labelColor: Colors.black,
                labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                    insets: EdgeInsets.symmetric(horizontal: 80),
                    borderSide: BorderSide(color: Colors.green)),
                tabs: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      "INGREDIENTS",
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      "METHOD",
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
