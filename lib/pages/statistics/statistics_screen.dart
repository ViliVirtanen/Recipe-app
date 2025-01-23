
import 'package:flutter/material.dart';
import 'package:recipe_manager/widgets/nav_bar.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: Center(
        child: Text('Statistics Screen and details here'),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}