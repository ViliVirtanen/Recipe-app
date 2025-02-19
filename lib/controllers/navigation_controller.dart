
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
    Get.offNamed(getRoute(index)); // Replaces the current page to prevent stacking
  }

  String getRoute(int idx) {
    switch (idx) {
      case 0:
        return '/';
      case 1:
        return '/add';
      case 2:
        return '/stats';
      default:
        return '/';
    }
  }
}