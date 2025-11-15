import 'package:flutter/material.dart';
import 'package:recipe_book/Models/category.dart';
import 'package:recipe_book/Screens/meal_list_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});
  final Category category;
  _loadCategoryMeals(BuildContext context) {
        print('Category ${category.strCategory} was clicked.');

        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> MealListScreen(category: category)));
      }
  @override
  Widget build(context) {
    return InkWell(
      key: ValueKey(category.idCategory),
      splashColor: Theme.of(context).primaryColor,
      onTap: (){
        _loadCategoryMeals(context);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
           gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.55),
                Theme.of(context).primaryColor.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
        child: Column(
          children: [
            Expanded(child: Image.network(category.strCategoryThumb)),
            Text(
              category.strCategory,
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
