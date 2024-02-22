import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'MakeUpController.dart';
import 'MakeUpListPage.dart';
import 'Tablet.dart';

class Products extends GetView<ProductController> {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => controller.isMobileLayout.value
            ? const MobileProduct()
            : const TabletProduct(),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            onTap: () {
              Get.toNamed("/favorite");
            },
            child: Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(64),
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        )
    );
  }
}
