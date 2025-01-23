import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:recipe_manager/pages/home/home_screen.dart';
import 'package:recipe_manager/pages/add/add_recipe_screen.dart';
import 'package:recipe_manager/pages/recipe_details/single_recipe_screen.dart';
import 'package:recipe_manager/pages/statistics/statistics_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("storage");
  //Get.lazyPut<EmailController>(() => EmailController()); example of controllers
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
        GetPage(name: "/add", page: () => const AddRecipeScreen()),
        GetPage(name: "/recipe/:id", page: () => SingleRecipeScreen()),
        GetPage(name: "/stats", page: () =>  StatisticsScreen()),
      ],
    );
  }
}
