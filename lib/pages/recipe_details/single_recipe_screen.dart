
import 'package:flutter/material.dart';
import 'package:recipe_manager/widgets/nav_bar.dart';

class SingleRecipeScreen extends StatelessWidget {
  const SingleRecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
      ),
      body: Center(
        child: Text('Single Recipe Screen and details here'),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}