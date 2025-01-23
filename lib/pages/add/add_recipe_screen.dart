
import 'package:flutter/material.dart';
import 'package:recipe_manager/widgets/nav_bar.dart';

class AddRecipeScreen extends StatelessWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recipe'),
      ),
      body: Center(
        child: Text('Add Recipe Screen and form here'),
      ),

      // Testing the NavigationBar
       bottomNavigationBar: NavBar(),
    );
  }
}