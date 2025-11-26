import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mis_lab2/models/meal_category_model.dart';

class CategoryCard extends StatelessWidget {
  final MealCategoryModel category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, "/details", arguments: category),
      child: Card(
        child: ListTile(
          title: Text(category.name),

          subtitle: Text("${category.description.substring(0,min(category.description.length, 70))}..."),

          trailing: Image.network(category.imageUrl),
        ),
      ),
    );
  }
}
