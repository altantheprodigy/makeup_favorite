
import 'package:get/get.dart';

import 'FavoriteController.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController());
  }
}