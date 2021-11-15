import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String? contry;
  final String? death;

  CategoryItem(this.contry, this.death);

  // void selectCategory(BuildContext ctx) {
  //   Navigator.of(ctx).pushNamed(
  //     CategoryMealsScreen.routeName,
  //     arguments: {
  //       'id': id,
  //       'title': title,
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color(0xff057163),
      decoration: BoxDecoration(
          color: const Color(0xff057163),
          borderRadius: BorderRadius.circular(15)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 14,
            child: Text(
              contry!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(death!, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
    //    child: Text(contry!),
    //     decoration: BoxDecoration(
    //         color: const Color(0xff057163),
    //         borderRadius: BorderRadius.circular(15)),
  }
}
