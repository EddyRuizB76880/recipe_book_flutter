import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/Models/meal_row_data.dart';
import 'package:recipe_book/State/favorite_meals_cubit.dart';

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({ super.key, required this.meal, this.tappable = false });

  final MealRowData meal;
  final bool tappable;

  @override
  State<FavoriteIcon> createState() {
    return _FavoriteIconState();
  }
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteMealsCubit, List<MealRowData>>(
      builder: (context, meals) {
        final bool isIncluded = context.read<FavoriteMealsCubit>().isIncluded(widget.meal.idMeal);
        final icon = context.read<FavoriteMealsCubit>().getCheckmarkIcon(widget.meal.idMeal);
        return widget.tappable ? IconButton(
          onPressed: () {
            String message = '';

            if (!isIncluded) {
              context.read<FavoriteMealsCubit>().addMeal(widget.meal);
              message = 'Meal added to the Favorites list!';
            }

            if (isIncluded) {
              context.read<FavoriteMealsCubit>().removeMeal(widget.meal.idMeal);
              message = 'Meal removed from the Favorites list.';
            }

            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          },
          icon: icon,
        ) : icon;
      },
    );
  }
}
