import 'package:flutter/material.dart';
import 'package:mis_lab2/models/meal_category_model.dart';

import 'category_card.dart';

class CategoriesGrid extends StatelessWidget{

  final List<MealCategoryModel> categories;

  const CategoriesGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {



    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => CategoryCard(category: categories[index]),
      separatorBuilder: (context, index) => SizedBox(height: 5),
      itemCount: categories.length,
    );

  }


}