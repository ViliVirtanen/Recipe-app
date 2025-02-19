
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class RecipeController extends GetxController {
  final storage = Hive.box("storage");
  RxList recipes;

  RecipeController() : recipes = [].obs {
    var storedRecipes = storage.get("recipes");
    if (storedRecipes == null || (storedRecipes as List).isEmpty) {
      // Initialize with sample data if no stored recipes exist
      recipes.value = [
        {
          'title': 'Classic Spaghetti Carbonara',
          'description': 'A traditional Italian pasta dish with eggs, cheese, pancetta, and black pepper.',
          'ingredients': '400g spaghetti\n200g pancetta or guanciale\n4 large eggs\n100g Pecorino Romano\n100g Parmigiano-Reggiano\nBlack pepper\nSalt',
          'steps': '1. Cook pasta in salted water\n2. Fry pancetta until crispy\n3. Mix eggs and cheese\n4. Combine all ingredients\n5. Season with black pepper',
          'category': 'Italian'
        },
        {
          'title': 'Chicken Stir-Fry',
          'description': 'Quick and healthy Asian-style stir-fry with vegetables.',
          'ingredients': '500g chicken breast\nMixed vegetables\nSoy sauce\nGinger\nGarlic\nOil\nCornstarch',
          'steps': '1. Cut chicken into pieces\n2. Prepare vegetables\n3. Heat wok\n4. Stir-fry chicken\n5. Add vegetables\n6. Season and serve',
          'category': 'Asian'
        },
        {
          'title': 'Greek Salad',
          'description': 'Fresh and healthy Mediterranean salad.',
          'ingredients': 'Tomatoes\nCucumber\nRed onion\nFeta cheese\nOlives\nOlive oil\nOregano',
          'steps': '1. Chop vegetables\n2. Combine in bowl\n3. Add feta and olives\n4. Dress with olive oil\n5. Season with oregano',
          'category': 'Mediterranean'
        }
      ];
      // Save sample data to storage
      storage.put("recipes", recipes);
    } else {
      recipes.value = storedRecipes;
    }
  }
  
  void saveRecipe(Map<String, dynamic> formData) {
    recipes.add(formData);
    storage.put("recipes", recipes);
    Get.snackbar("Success", "Recipe added successfully!");
  }
  void updateRecipe(Map<String, dynamic> formData, int index) {
    recipes[index] = formData;
    storage.put("recipes", recipes);
    Get.snackbar("Success", "Recipe updated successfully!");
  }
  void deleteRecipe(int index) {
    recipes.removeAt(index);
    storage.put("recipes", recipes);
    Get.snackbar("Success", "Recipe deleted successfully!");
  }
}
