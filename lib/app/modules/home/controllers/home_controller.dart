import '../../../data/models/recipe_model.dart';
import 'package:get/get.dart';

import '../../../data/local/local_provider.dart';

class HomeController extends GetxController with StateMixin<List<RecipeModel>> {
  LocalProvider localProvider = LocalProvider();
  var recipes = RxList<RecipeModel>();
  var currentIndex = 0.obs;

  void readRecipe() async {
    final data = await localProvider.loadData();
    final result = await localProvider.readRecipe(data);
    try {
      if (result.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        recipes.addAll(result);
        change(result, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  @override
  void onReady() {
    readRecipe();
    super.onReady();
  }
}
