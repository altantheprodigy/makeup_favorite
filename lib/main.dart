import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:makeup_favorite/Pages/Favorite/FavoriteView.dart';

import 'Api/ApiMakeup.dart';
import 'DB/db_helper.dart';
import 'Pages/Favorite/FavoriteBinding.dart';
import 'Pages/MakeUpList/Carousel.dart';
import 'Pages/MakeUpList/MakeUpBinding.dart';
import 'Pages/MakeUpList/MakeUpView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MakeupApi());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: "/products",
      getPages: [
        GetPage(
            name: "/products",
            page: () => const Products(),
            binding: ProductBinding()),
        GetPage(
            name: "/carousel",
            page: () =>  CarouselPage(),
            binding: ProductBinding()),
        GetPage(
            name: "/favorite",
            page: () => const FavoritePages(),
            binding: FavoriteBinding()),
      ],
    );
  }
}