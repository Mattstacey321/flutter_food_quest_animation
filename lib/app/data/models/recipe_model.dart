import 'dart:convert';

import 'package:flutter_food_quest_animation/app/data/models/ingredient_model.dart';
import 'package:flutter_food_quest_animation/app/data/models/instructions_model.dart';

class RecipeModel {
  String name;
  String image;
  List<IngredientModel> ingredients;
  List<InstructionModel> instructions;
  int servings;
  int prepareTime;
  int cookTime;
  int get totalTime => prepareTime + cookTime;

  RecipeModel({
    required this.name,
    required this.image,
    required this.ingredients,
    required this.instructions,
    required this.servings,
    required this.prepareTime,
    required this.cookTime,
  });

  RecipeModel copyWith({
    String? name,
    String? image,
    List<IngredientModel>? ingredients,
    List<InstructionModel>? instructions,
    int? servings,
    int? prepareTime,
    int? cookTime,
  }) {
    return RecipeModel(
      name: name ?? this.name,
      image: image ?? this.image,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      servings: servings ?? this.servings,
      prepareTime: prepareTime ?? this.prepareTime,
      cookTime: cookTime ?? this.cookTime,
    );
  }

  static List<RecipeModel> fromList(List<dynamic> json) {
    return json.isEmpty ? [] : json.map((e) => RecipeModel.fromMap(e)).toList();
  }

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      name: map['name'],
      image: map['image'],
      ingredients:
          List<IngredientModel>.from(map['ingredients']?.map((x) => IngredientModel.fromMap(x))),
      instructions:
          List<InstructionModel>.from(map['instructions']?.map((x) => InstructionModel.fromMap(x))),
      servings: map['servings'],
      prepareTime: map['prep_time'],
      cookTime: map['cook_time'],
    );
  }

  factory RecipeModel.fromJson(String source) => RecipeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RecipeModel(name: $name, image: $image, ingredients: $ingredients, instructions: $instructions, servings: $servings, prepareTime: $prepareTime, cookTime: $cookTime)';
  }
}
