import 'package:flutter/material.dart';
import 'package:recipe_book/Models/category.dart';
import 'package:recipe_book/Models/meal_row_data.dart';

class MealRow extends StatelessWidget {
  const MealRow({super.key, required this.mealRowData});
  final MealRowData mealRowData;

  @override
  Widget build(context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      onTap: () {
        print('Meal ${mealRowData.strMeal} was clicked.');
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 5),

        child: Stack(
          alignment: AlignmentGeometry.bottomCenter,
          key: ValueKey(mealRowData.idMeal),
          children: [
            Image.network(
              mealRowData.strMealThumb,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(color: Color.fromARGB(113, 0, 0, 0)),
              height: 30,
            ),

            Text(
              textAlign: TextAlign.center,
              mealRowData.strMeal,
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
