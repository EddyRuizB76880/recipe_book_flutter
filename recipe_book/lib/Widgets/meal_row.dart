import 'package:flutter/material.dart';
import 'package:recipe_book/Models/meal_row_data.dart';
import 'package:recipe_book/Screens/meal_details_screen.dart';
import 'package:recipe_book/Widgets/favorite_icon.dart';

class MealRow extends StatelessWidget {
  const MealRow({super.key, required this.mealRowData});
  final MealRowData mealRowData;

  @override
  Widget build(context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      onTap: () {
        print('Meal ${mealRowData.idMeal} was clicked.');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MealDetailsScreen(idMeal: mealRowData.idMeal),
          ),
        );
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
              mealRowData.strMealThumb ??
                  'https://cdn-icons-png.freepik.com/512/1046/1046874.png',
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(color: Color.fromARGB(113, 0, 0, 0)),
              height: 30,
            ),

            Row(
              children: [
                FavoriteIcon(meal: mealRowData),
                Expanded(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    mealRowData.strMeal,
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
