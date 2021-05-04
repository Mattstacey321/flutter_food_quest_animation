import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeItem extends StatelessWidget {
  final String name;
  final String image;
  RecipeItem({required this.image, required this.name});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 100,
        width: Get.width,
        child: Row(
          children: <Widget>[
            Image.asset(
              image,
              height: 100,
              width: 100,
            ),
            const SizedBox(width: 10),
            Column(
              children: [Text(name), Text("Vegetarian")],
            )
          ],
        ),
      ),
    );
  }
}
