import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../MakeUpList/MakeUpController.dart';
import 'FavoritPages.dart';
import 'FavoriteController.dart';

class FavoritePages extends GetView<FavoriteController> {
  const FavoritePages({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController layoutController = Get.put(ProductController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Favorite",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() => layoutController.isMobileLayout.value
          ? MobileFavorite(favoriteController: controller)
          : MobileFavorite(favoriteController: controller)),
    );
  }
}