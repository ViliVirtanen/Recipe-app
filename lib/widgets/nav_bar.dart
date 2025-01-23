import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NavBar extends StatelessWidget {

String getRoute(int idx) {
    switch (idx) {
      case 0:
        return '/home';
      case 1:
        return '/add';
      case 2:
        return '/stats';
      default:
        return '/home';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        onDestinationSelected: (int index) {
          // navigate to the selected page
          Get.toNamed(getRoute(index));
        },
        //indicatorColor: Colors.amber,
        //selectedIndex: currentPageIndex,
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
      );
  }
}