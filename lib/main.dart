import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:recipe_manager/controllers/navigation_controller.dart';
import 'package:recipe_manager/controllers/recipe_controller.dart';
import 'package:recipe_manager/pages/home_screen.dart';
import 'package:recipe_manager/pages/add_recipe_screen.dart';
import 'package:recipe_manager/pages/single_recipe_screen.dart';
import 'package:recipe_manager/pages/statistics_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("storage");
  //Get.lazyPut<EmailController>(() => EmailController()); example of controllers
  Get.put(NavigationController(), permanent: true);
  Get.put(RecipeController(), permanent: true);
  runApp(const MainApp());
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => HomeScreen()),
        GetPage(name: "/add", page: () => AddRecipeScreen()),
        GetPage(name: "/recipe/:id", page: () => SingleRecipeScreen()),
        GetPage(name: "/edit-recipe/:id", page: () => AddRecipeScreen()),
        GetPage(name: "/stats", page: () => StatisticsScreen()),
      ],
    );
  }
}
