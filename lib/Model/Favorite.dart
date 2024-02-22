class Favorite {
  int id;
  String title;
  String image;
  String harga;

  Favorite({required this.id, required this.title, required this.image, required this.harga});

  Favorite.fromMap({required map})
      : id = map["id"],
        title = map["title"] ?? "",
        harga = map["harga"] ?? "",
        image = map["image"] ?? "";

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "image": image, "harga":harga};
  }
}