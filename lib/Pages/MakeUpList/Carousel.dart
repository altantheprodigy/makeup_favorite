import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Api/ApiMakeup.dart';
import '../../Model/Favorite.dart';
import '../Favorite/FavoriteController.dart';


class CarouselPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController = Get.put(FavoriteController());
    final MakeupApi apiController = Get.put(MakeupApi());
    return Obx(() {
      if (apiController.isOffline.value) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_wifi_connected_no_internet_4_rounded,
                size: 72,
              ),
              SizedBox(height: 20),
              Text(
                'Uh Oh No internet',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        );
      } else {
        if (apiController.belajarApi.isEmpty) {
          return const Center(
            child: Text(
              'No data available',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w900),
            ),
          );
        } else {
          return CarouselSlider.builder(
            itemCount: apiController.belajarApi.length,
            options: CarouselOptions(
              height: 150.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16/9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            itemBuilder: (context, index, realIndex) {
              final data = apiController.belajarApi[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFd5d5d5).withOpacity(1),
                      offset: const Offset(8, 8),
                      blurRadius: 50,
                      spreadRadius: -10,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Image.network(
                        data.imageLink,
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.name,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis, // Add this line
                                maxLines: 1, // Add this line to limit the number of lines
                              ),
                              Text(
                                data.price + " Dollar",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Obx(
                                        () =>
                                        IconButton(
                                          onPressed: () {
                                            favoriteController.tapLike(
                                              Favorite(
                                                  id: data.id,
                                                  title: data.name,
                                                  harga: data.price,
                                                  image: data.imageLink),
                                            );
                                          },
                                          icon: Icon(
                                            favoriteController
                                                .checkFavorite(data.id)
                                                .value
                                                ? Icons.favorite_rounded
                                                : Icons
                                                .favorite_outline_rounded,
                                            size: 20,
                                            color: Colors.red,
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }
    });
  }
}