import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../DB/db_helper.dart';

class ProductController extends GetxController with WidgetsBindingObserver {
  Database db = DbHelper.getDb();
  RxBool isMobileLayout = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    checkScreenWidth();
  }

  void checkScreenWidth() {
    double screenWidth = Get.width;
    isMobileLayout.value = screenWidth < 640;
  }

  @override
  void didChangeMetrics() {
    checkScreenWidth();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
