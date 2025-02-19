import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:recipe_manager/controllers/recipe_controller.dart';
import 'package:recipe_manager/widgets/nav_bar.dart';

class AddRecipeScreen extends StatelessWidget {
  AddRecipeScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  final RecipeController recipeController = Get.find<RecipeController>();
  final recipeIndex = int.tryParse(Get.parameters['id'] ?? '');

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> recipe = {
      'title': '',
      'description': '',
      'ingredients': '',
      'steps': '',
      'category': '',
    };

    if (recipeIndex != null && recipeIndex! >= 0 && recipeIndex! < recipeController.recipes.length) {
      final temp = recipeController.recipes[recipeIndex!];
      recipe['title'] = temp['title'];
      recipe['description'] = temp['description'];
      recipe['ingredients'] = temp['ingredients'];
      recipe['steps'] = temp['steps'];
      recipe['category'] = temp['category'];
    }

    return Scaffold(
      appBar: AppBar(title: Text(recipeIndex != null ? 'Edit Recipe' : 'Add Recipe')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isTablet = constraints.maxWidth > 600;
              
              return SingleChildScrollView(
                padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
                child: FormBuilder(
                  key: _formKey,
                  initialValue: {
                    'title': recipe['title'],
                    'description': recipe['description'] ?? '',
                    'ingredients': recipe['ingredients'],
                    'steps': recipe['steps'],
                    'category': recipe['category'],
                  },
                  child: isTablet 
                      ? _buildTabletLayout()
                      : _buildMobileLayout(),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormField('title', 'Recipe Title', 1),
        const SizedBox(height: 10),
        _buildFormField('description', 'Description', 2),
        const SizedBox(height: 10),
        _buildFormField('ingredients', 'Ingredients', 3),
        const SizedBox(height: 10),
        _buildFormField('steps', 'Steps', 4),
        const SizedBox(height: 10),
        _buildCategoryDropdown(),
        const SizedBox(height: 20),
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  _buildFormField('title', 'Recipe Title', 1),
                  const SizedBox(height: 16),
                  _buildFormField('description', 'Description', 3),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                children: [
                  _buildCategoryDropdown(),
                  const SizedBox(height: 16),
                  _buildFormField('ingredients', 'Ingredients', 3),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildFormField('steps', 'Steps', 6),
        const SizedBox(height: 20),
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildFormField(String name, String label, int maxLines) {
    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      maxLines: maxLines,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        if (name == 'title') FormBuilderValidators.minLength(3),
      ]),
    );
  }

  Widget _buildCategoryDropdown() {
    return FormBuilderDropdown<String>(
      name: 'category',
      decoration: const InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(),
      ),
      items: ['Breakfast', 'Lunch', 'Dinner', 'Dessert']
          .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category),
              ))
          .toList(),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            if (recipeIndex != null && recipeIndex! >= 0 && recipeIndex! < recipeController.recipes.length) {
              recipeController.updateRecipe(_formKey.currentState!.value, recipeIndex!);
              Get.offNamed('/recipe/$recipeIndex');
            } else {
              recipeController.saveRecipe(_formKey.currentState!.value);
              _formKey.currentState?.reset();
            }
          } else {
            Get.snackbar("Error", "Please fix the errors in the form.");
          }
        },
        child: Text(
          recipeIndex != null ? 'Update Recipe' : 'Save Recipe',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
