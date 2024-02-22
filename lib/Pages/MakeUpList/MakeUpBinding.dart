import 'package:get/get.dart';

import 'MakeUpController.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
  }
}