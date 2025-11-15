import 'package:flutter/material.dart';
import 'package:recipe_book/State/favorite_meals_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/Models/meal_row_data.dart';
import 'package:recipe_book/Widgets/meal_list.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FavoritesScreenState();
  }
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteMealsCubit, List<MealRowData>>(
      builder: (context, meals) {
        dynamic content = MealList(meals: meals);

        if (meals.isEmpty) {
          content = Center(
            child: Text('No favorites found. Start adding in Categories!'),
          );
        }

        return content;
      },
    );
  }
}
