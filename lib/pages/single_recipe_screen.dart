
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_manager/controllers/recipe_controller.dart';
import 'package:recipe_manager/widgets/nav_bar.dart';

class SingleRecipeScreen extends StatelessWidget {
  SingleRecipeScreen({Key? key}) : super(key: key);

  final RecipeController recipeController = Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
    final recipeIndex = int.tryParse(Get.parameters['id'] ?? '');
    if (recipeIndex == null || recipeIndex < 0 || recipeIndex >= recipeController.recipes.length) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recipe Not Found')),
        body: const Center(child: Text('The requested recipe does not exist.')),
        bottomNavigationBar: NavBar(),
      );
    }

    final recipeData = recipeController.recipes[recipeIndex];
    final recipe = Map<String, dynamic>.from(recipeData);

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['title']),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isTablet = constraints.maxWidth > 600;
              return SingleChildScrollView(
                padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
                child: isTablet
                    ? _buildTabletLayout(recipe, recipeIndex)
                    : _buildMobileLayout(recipe, recipeIndex),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }

  Widget _buildMobileLayout(Map<String, dynamic> recipe, int recipeIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(recipe),
        const SizedBox(height: 24),
        _buildDescription(recipe),
        const SizedBox(height: 24),
        _buildIngredients(recipe),
        const SizedBox(height: 24),
        _buildSteps(recipe),
        const SizedBox(height: 24),
        _buildActionButtons(recipeIndex, recipe),
      ],
    );
  }

  Widget _buildTabletLayout(Map<String, dynamic> recipe, int recipeIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(recipe),
        const SizedBox(height: 24),
        _buildDescription(recipe),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildIngredients(recipe),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 3,
              child: _buildSteps(recipe),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildActionButtons(recipeIndex, recipe),
      ],
    );
  }

  Widget _buildHeader(Map<String, dynamic> recipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipe['title'],
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            recipe['category'] == "" ? 'Uncategorized' : recipe['category'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(Map<String, dynamic> recipe) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              recipe['description'],
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredients(Map<String, dynamic> recipe) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.format_list_bulleted),
                SizedBox(width: 8),
                Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              recipe['ingredients'],
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSteps(Map<String, dynamic> recipe) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.format_list_numbered),
                SizedBox(width: 8),
                Text(
                  'Steps',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              recipe['steps'],
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(int recipeIndex, Map<String, dynamic> recipe) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Get.toNamed('/edit-recipe/$recipeIndex');
            },
            icon: const Icon(Icons.edit),
            label: const Text('Edit Recipe'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Get.defaultDialog(
                title: 'Delete Recipe',
                middleText: 'Are you sure you want to delete this recipe?',
                textConfirm: 'Delete',
                textCancel: 'Cancel',
                confirmTextColor: Colors.white,
                onConfirm: () {
                  recipeController.deleteRecipe(recipeIndex);
                  Get.offAllNamed('/');
                },
              );
            },
            icon: const Icon(Icons.delete),
            label: const Text('Delete Recipe'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
