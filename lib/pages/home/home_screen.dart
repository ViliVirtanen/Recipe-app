
import 'package:flutter/material.dart';
import 'package:recipe_manager/widgets/nav_bar.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Manager'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Recipes',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // Recipe List
          Expanded(
            child: Text('Recipe List test'),
          ),
        ],
      ),
      // Testing the NavigationBar
       bottomNavigationBar: NavBar(),
    );
  }
}