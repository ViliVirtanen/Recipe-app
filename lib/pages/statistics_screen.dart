
import 'package:flutter/material.dart';
import 'package:recipe_manager/widgets/nav_bar.dart';
import 'package:get/get.dart';
import 'package:recipe_manager/controllers/recipe_controller.dart';

class StatisticsScreen extends StatelessWidget {
  StatisticsScreen({Key? key}) : super(key: key);

  final recipeController = Get.find<RecipeController>();

  Map<String, int> getCategoryDistribution() {
    final Map<String, int> distribution = {};
    for (var recipeData in recipeController.recipes) {
      final recipe = Map<String, dynamic>.from(recipeData);
      final category = (recipe['category'] as String?)?.isEmpty ?? true
          ? 'Uncategorized'
          : recipe['category'] as String;
      distribution[category] = (distribution[category] ?? 0) + 1;
    }
    return distribution;
  }

  Map<String, dynamic> getRecipeStats() {
    if (recipeController.recipes.isEmpty) {
      return {
        'total': 0,
        'avgIngredients': '0',
        'avgSteps': '0',
        'longest': 0,
        'shortest': 0,
      };
    }

    int totalIngredients = 0;
    int totalSteps = 0;
    int longestRecipe = 0;
    int shortestRecipe = double.maxFinite.toInt();

    for (var recipeData in recipeController.recipes) {
      final recipe = Map<String, dynamic>.from(recipeData);
      final ingredients = (recipe['ingredients'] as String? ?? '')
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .length;
      final steps = (recipe['steps'] as String? ?? '')
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .length;

      totalIngredients += ingredients;
      totalSteps += steps;
      longestRecipe = ingredients > longestRecipe ? ingredients : longestRecipe;
      shortestRecipe = ingredients < shortestRecipe ? ingredients : shortestRecipe;
    }

    return {
      'total': recipeController.recipes.length,
      'avgIngredients': (totalIngredients / recipeController.recipes.length).toStringAsFixed(1),
      'avgSteps': (totalSteps / recipeController.recipes.length).toStringAsFixed(1),
      'longest': longestRecipe,
      'shortest': shortestRecipe == double.maxFinite.toInt() ? 0 : shortestRecipe,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Statistics'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Obx(() {
            if (recipeController.recipes.isEmpty) {
              return const Center(
                child: Text('No recipes added yet.'),
              );
            }

            final stats = getRecipeStats();
            final categoryStats = getCategoryDistribution();

            return LayoutBuilder(
              builder: (context, constraints) {
                final isTablet = constraints.maxWidth > 600;
                
                return SingleChildScrollView(
                  padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
                  child: isTablet
                      ? _buildTabletLayout(stats, categoryStats)
                      : _buildMobileLayout(stats, categoryStats),
                );
              },
            );
          }),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }

  Widget _buildMobileLayout(Map<String, dynamic> stats, Map<String, int> categoryStats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOverviewCard(stats),
        const SizedBox(height: 20),
        _buildCategoryCard(categoryStats),
      ],
    );
  }

  Widget _buildTabletLayout(Map<String, dynamic> stats, Map<String, int> categoryStats) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _buildOverviewCard(stats),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 2,
          child: _buildCategoryCard(categoryStats),
        ),
      ],
    );
  }

  Widget _buildOverviewCard(Map<String, dynamic> stats) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            StatItem(
              icon: Icons.book,
              label: 'Total Recipes',
              value: '${stats['total']}',
            ),
            StatItem(
              icon: Icons.format_list_bulleted,
              label: 'Average Ingredients per Recipe',
              value: '${stats['avgIngredients']}',
            ),
            StatItem(
              icon: Icons.format_list_numbered,
              label: 'Average Steps per Recipe',
              value: '${stats['avgSteps']}',
            ),
            StatItem(
              icon: Icons.arrow_upward,
              label: 'Most Ingredients in a Recipe',
              value: '${stats['longest']}',
            ),
            StatItem(
              icon: Icons.arrow_downward,
              label: 'Least Ingredients in a Recipe',
              value: '${stats['shortest']}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, int> categoryStats) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recipe Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            if (categoryStats.isEmpty)
              const Text('No categories yet')
            else
              ...categoryStats.entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            entry.key,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${entry.value} ${entry.value == 1 ? 'recipe' : 'recipes'}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const StatItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 24, color: Colors.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
