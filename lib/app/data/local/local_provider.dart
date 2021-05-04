import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/recipe_model.dart';

class LocalProvider {
  Future<List<dynamic>> loadData() async {
    String data = await rootBundle.loadString('assets/data.json');
    final jsonResult = json.decode(data);
    return jsonResult;
  }

  Future<List<RecipeModel>> readRecipe(List<dynamic> json) async {
    final result = RecipeModel.fromList(json);
    return result;
  }
}
