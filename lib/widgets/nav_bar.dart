import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';

class NavBar extends StatelessWidget {
  final navController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => NavigationBar(
          selectedIndex: navController.selectedIndex.value,
          onDestinationSelected: (int index) {
            navController.updateIndex(index);
          },
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.add),
              label: 'Add Recipe',
            ),
            NavigationDestination(
              icon: Badge(
                child: Icon(Icons.query_stats),
              ),
              label: 'Statistics',
            ),
          ],
        ));
  }
}