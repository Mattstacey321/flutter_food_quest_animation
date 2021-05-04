import 'package:flutter/material.dart';
import 'package:flutter_food_quest_animation/app/data/global_widgets/quest_info.dart';
import 'package:get/get.dart';

import '../../../data/global_widgets/show_up_animation.dart';
import '../../../data/models/ingredient_model.dart';
import '../../../data/models/instructions_model.dart';
import '../../../data/models/recipe_model.dart';
import '../controllers/recipe_detail_controller.dart';
import '../widgets/custom_tab_bar.dart';

class RecipeDetail extends StatelessWidget {
  final RecipeModel recipe;
  RecipeDetail({required this.recipe});
  @override
  Widget build(BuildContext context) {
    final ingredients = recipe.ingredients;
    final instructions = recipe.instructions;
    return Scaffold(
        body: GetBuilder<RecipeDetailController>(
      init: RecipeDetailController(),
      builder: (controller) => Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: <Widget>[
            //back button
            Container(
              height: 50,
              padding: EdgeInsets.only(top: 20, left: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            _buildImage(),
            const SizedBox(height: 20),
            _buildRecipeTitle(),
            const SizedBox(height: 10),
            _buildTotalTimeAndExp(),
            const SizedBox(height: 10),
            Expanded(
              child: _buildTabView(ingredients, instructions, controller),
            )
          ],
        ),
      ),
    ));
  }

  Widget _buildTabView(List<IngredientModel> ingredients, List<InstructionModel> instructions,
      RecipeDetailController controller) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTabBar(),
          Flexible(
            child: ShowUpAnimation(
              child: PageView(
                onPageChanged: controller.onPageChange,
                controller: controller.pageController,
                children: [
                  _buildIngredient(ingredients),
                  _buildMethod(instructions),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTotalTimeAndExp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Hero(
              tag: "time",
              child: QuestInfo(
                icon: Icons.watch_later_outlined,
                title: recipe.totalTime.toString(),
                textColor: Colors.grey,
              )),
          const SizedBox(width: 15),
          Hero(
            tag: "exp",
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.emoji_events_outlined,
                    color: Color(0xff17c37b),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "+ ${recipe.exp} exp",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Hero(
      tag: recipe.id,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Image.asset(
          recipe.image,
          height: 300,
          width: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildRecipeTitle() {
    return Hero(
      tag: recipe.name,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              recipe.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMethod(List<InstructionModel> instructions) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              instructions[index].name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            for (var item in instructions[index].steps)
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Text("$item"),
              )
          ],
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: instructions.length,
    );
  }

  Widget _buildIngredient(List<IngredientModel> ingredients) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${ingredients[index].name}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            for (var item in ingredients[index].parts)
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: Text("${item.quantity} ${item.unit} ${item.type}"),
              )
          ],
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: ingredients.length,
    );
  }
}
