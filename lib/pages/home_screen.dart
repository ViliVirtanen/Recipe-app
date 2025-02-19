
import 'package:flutter/material.dart';
import 'package:recipe_manager/widgets/nav_bar.dart';
import 'package:get/get.dart';
import 'package:recipe_manager/controllers/recipe_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final recipeController = Get.find<RecipeController>();
  final searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  List<dynamic> filterRecipes(List<dynamic> recipes, String query) {
    if (query.isEmpty) return List<dynamic>.from(recipes);
    
    return recipes.where((recipe) {
      final Map<String, dynamic> recipeMap = Map<String, dynamic>.from(recipe);
      final title = recipeMap['title'].toString().toLowerCase();
      final description = (recipeMap['description'] ?? '').toString().toLowerCase();
      final category = (recipeMap['category'] ?? '').toString().toLowerCase();
      final ingredients = recipeMap['ingredients'].toString().toLowerCase();
      
      final searchLower = query.toLowerCase();
      
      return title.contains(searchLower) ||
             description.contains(searchLower) ||
             category.contains(searchLower) ||
             ingredients.contains(searchLower);
    }).map((recipe) => Map<String, dynamic>.from(recipe)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Manager'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) => searchQuery.value = value,
                  decoration: const InputDecoration(
                    labelText: 'Search Recipes',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search by title, category, or ingredients...',
                  ),
                ),
              ),
              // Recipe List
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(() {
                    if (recipeController.recipes.isEmpty) {
                      return const Center(child: Text('No recipes added yet.'));
                    }
                    final filteredRecipes = filterRecipes(
                      recipeController.recipes,
                      searchQuery.value
                    );
                    if (filteredRecipes.isEmpty) {
                      return const Center(
                        child: Text('No recipes match your search.'),
                      );
                    }

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final isTablet = constraints.maxWidth > 600;
                        
                        if (isTablet) {
                          return GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: filteredRecipes.length,
                            itemBuilder: (context, index) {
                              final recipe = filteredRecipes[index];
                              return _buildRecipeCard(recipe);
                            },
                          );
                        }

                        return ListView.builder(
                          itemCount: filteredRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = filteredRecipes[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: _buildRecipeCard(recipe),
                            );
                          },
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }

  Widget _buildRecipeCard(dynamic recipeData) {
    final recipe = Map<String, dynamic>.from(recipeData);
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(
          recipe['title'], 
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
        ),
        subtitle: Text(
          recipe['category'] == "" ? 'Uncategorized' : recipe['category']
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            Get.defaultDialog(
              title: 'Delete Recipe',
              middleText: 'Are you sure you want to delete this recipe?',
              textConfirm: 'Delete',
              textCancel: 'Cancel',
              confirmTextColor: Colors.white,
              onConfirm: () {
                recipeController.deleteRecipe(
                  recipeController.recipes.indexOf(recipeData)
                );
                Get.back(closeOverlays: true);
              }
            );
          },
        ),
        onTap: () {
          Get.toNamed('/recipe/${recipeController.recipes.indexOf(recipeData)}');
        },
      ),
    );
  }
}
