import 'package:flutter/material.dart';
import 'package:recipe_book/Models/meal_row_data.dart';
import 'package:recipe_book/Widgets/meal_row.dart';

class MealList extends StatelessWidget {
  MealList({super.key, required this.meals});

  List<MealRowData> meals = [];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        for (final entry in meals)
          MealRow(
            mealRowData: entry
          ),
      ],
    );
  }
}
