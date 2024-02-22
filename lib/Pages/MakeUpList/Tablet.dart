


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Api/ApiMakeup.dart';

class TabletProduct extends StatelessWidget {
  const TabletProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final MakeupApi apiController = Get.put(MakeupApi());
    return Obx(() {
      return apiController.belajarApi.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: calculateCrossAxisCount(context),
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.6,
        ),
        itemCount: apiController.belajarApi.length,
        itemBuilder: (context, index) {
          final data = apiController.belajarApi[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                  data.imageLink,
                  width: 150,
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Icon(
                            Icons.favorite_outline_rounded,
                            size: 35,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  int calculateCrossAxisCount(BuildContext context) {
    double itemWidth = 250.0;

    int crossAxisCount =
    (MediaQuery.of(context).size.width / itemWidth).floor();

    return crossAxisCount > 0 ? crossAxisCount : 1;
  }
}