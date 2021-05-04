import 'package:flutter/material.dart';
import 'package:flutter_food_quest_animation/app/data/global_widgets/quest_info.dart';
import 'package:get/get.dart';

import '../../../data/models/recipe_model.dart';
import '../../recipe_detail/views/recipe_detail_view.dart';
import '../../../data/global_widgets/show_up_animation.dart';

class QuestItem extends StatefulWidget {
  final RecipeModel item;
  final double rotationValue;
  final Animation<Color?> textColorAnim;
  final bool isReverse;
  QuestItem(
      {required this.item,
      required this.textColorAnim,
      required this.rotationValue,
      this.isReverse = false});
  @override
  _QuestItemState createState() => _QuestItemState();
}

class _QuestItemState extends State<QuestItem> with SingleTickerProviderStateMixin {
  RecipeModel get recipe => widget.item;
  double get rotationValue => widget.rotationValue;
  Animation<Color?> get textColor => widget.textColorAnim;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      padding: EdgeInsets.only(bottom: 20, left: 20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildRecipeTitle(),
              Expanded(
                flex: 4,
                child: Container(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          QuestInfo(
                            icon: Icons.kitchen_outlined,
                            title: "Medium",
                            textColor: textColor.value!,
                          ),
                          const SizedBox(height: 20),
                          Hero(
                            tag: "time",
                            child: QuestInfo(
                              icon: Icons.watch_later_outlined,
                              title: "${recipe.cookTime} mins",
                              textColor: textColor.value!,
                            ),
                          ),
                          const SizedBox(height: 20),
                          QuestInfo(
                            icon: Icons.health_and_safety_outlined,
                            title: "Healthy",
                            noAnimation: true,
                            textColor: textColor.value!,
                          ),
                          const SizedBox(height: 20),
                          Hero(
                              tag: "exp",
                              child: QuestInfo(
                                icon: Icons.emoji_events_outlined,
                                title: "+${recipe.exp} exp",
                                textColor: textColor.value!,
                              ))
                        ],
                      ),
                      _buildImage(),
                    ],
                  ),
                ),
              ),
              Expanded(flex: 2, child: _buildRecipeDetail()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeTitle() {
    return Hero(
      tag: recipe.name,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: Get.height / 10,
          width: Get.width / 1.5,
          alignment: Alignment.topLeft,
          child: ShowUpAnimation(
            offset: widget.isReverse ? -0.2 : 0.2,
            child: Text(
              recipe.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: textColor.value,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Positioned.fill(
      right: -Get.width / 2.5,
      child: Hero(
        tag: recipe.id,
        child: Align(
          alignment: Alignment.centerRight,
          child: Transform.rotate(
            angle: rotationValue,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Image.asset(
                recipe.image,
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeDetail() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: ShowUpAnimation(
                offset: widget.isReverse ? -0.2 : 0.2,
                delayStart: 150.milliseconds,
                child: Text(
                  recipe.description,
                  style: TextStyle(
                    color: textColor.value,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            //
            RotationTransition(
              turns: new AlwaysStoppedAnimation(45 / 360),
              child: FloatingActionButton(
                onPressed: () {
                  Get.to(() => RecipeDetail(recipe: recipe));
                },
                backgroundColor: Color(0xff17c37b),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: RotationTransition(
                  turns: new AlwaysStoppedAnimation(-45 / 360),
                  child: Icon(Icons.arrow_forward),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
