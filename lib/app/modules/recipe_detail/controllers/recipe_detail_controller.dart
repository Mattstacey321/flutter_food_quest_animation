import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeDetailController extends GetxController with SingleGetTickerProviderMixin {
  late PageController pageController;
  late TabController tabController;

  void onPageChange(int index) {
    tabController.animateTo(index);
  }

  @override
  void onInit() {
    pageController = PageController();
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (tabController.indexIsChanging) {
          pageController.animateToPage(
            tabController.index,
            duration: 200.milliseconds,
            curve: Curves.fastOutSlowIn,
          );
        }
      });
    super.onInit();
  }
}
