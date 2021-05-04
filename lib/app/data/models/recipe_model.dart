import 'dart:convert';

import 'ingredient_model.dart';
import 'instructions_model.dart';

class RecipeModel {
  int id;
  String name;
  int exp;
  String image;
  String description;
  List<IngredientModel> ingredients;
  List<InstructionModel> instructions;
  int servings;
  int prepareTime;
  int cookTime;
  int get totalTime => prepareTime + cookTime;

  RecipeModel({
    required this.id,
    required this.name,
    required this.exp,
    required this.image,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.servings,
    required this.prepareTime,
    required this.cookTime,
  });

  RecipeModel copyWith({
    int? id,
    String? name,
    int? exp,
    String? image,
    String? description,
    List<IngredientModel>? ingredients,
    List<InstructionModel>? instructions,
    int? servings,
    int? prepareTime,
    int? cookTime,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      exp: exp ?? this.exp,
      description: description ?? this.description,
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
      id: map['id'],
      name: map['name'],
      exp: map['exp'],
      image: map['image'],
      description: map['description'],
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
