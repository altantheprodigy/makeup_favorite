import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

import '../../DB/db_helper.dart';
import '../../Model/Favorite.dart';

class FavoriteController extends GetxController {
  Database db = DbHelper.getDb();
  RxBool isLoading = false.obs;
  RxList<Favorite> favorites = <Favorite>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFavorite();
  }

  RxBool checkFavorite(int id) {
    return (favorites.any((item) => item.id == id)).obs;
  }

  void tapLike(Favorite item) {
    if(checkFavorite(item.id).value){
      removeFavorite(item);
    } else {
      addFavorite(item);
    }
  }

  void addFavorite(Favorite item) async {
    isLoading.value = true;
    var response = await get(Uri.parse(item.image));
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = "${documentDirectory.path}/images";
    var filePathAndName = '${documentDirectory.path}/images/${item.id}.png';
    await Directory(firstPath).create(recursive: true);
    File file = File(filePathAndName);
    if (!await file.exists()) {
      file.writeAsBytesSync(response.bodyBytes);
      Favorite favorite = Favorite(
        id: item.id,
        harga: item.harga,
        title: item.title,
        image: filePathAndName,
      );
      await db.insert("MakeUp", favorite.toMap());
    }
    getFavorite();
  }

  void getFavorite() async {
    isLoading.value = true;
    List<Map<String, dynamic>> mapFavorites = await db.query("MakeUp");
    favorites.value = mapFavorites.map((e) => Favorite.fromMap(map: e)).toList();
    isLoading.value = false;
  }

  void removeFavorite(Favorite item) async {
    isLoading.value = true;
    await db.delete(
      "MakeUp",
      where: 'id = ?',
      whereArgs: [item.id],
    );
    var documentDirectory = await getApplicationDocumentsDirectory();
    var filePathAndName = '${documentDirectory.path}/images/${item.id}.png';
    File file = File(filePathAndName);

    if (await file.exists()) {
      await file.delete();
    }
    getFavorite();
  }
}