import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/State/cooked_meals_cubit.dart';

class CookedIcon extends StatefulWidget {
  const CookedIcon({ super.key, required this.idMeal, this.tappable = false });

  final int idMeal;
  final bool tappable;

  @override
  State<CookedIcon> createState() {
    return _CookedIconState();
  }
}

class _CookedIconState extends State<CookedIcon> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CookedMealsCubit, List<int>>(
      builder: (context, mealIds) {
        final bool isIncluded = context.read<CookedMealsCubit>().isIncluded(widget.idMeal);
        final icon = context.read<CookedMealsCubit>().getChecmarkIcon(widget.idMeal);
        return widget.tappable ? IconButton(
          onPressed: () {
            String message = '';

            if (!isIncluded) {
              context.read<CookedMealsCubit>().addMeal(widget.idMeal);
              message = 'Meal added to the Cooked list!';
            }

            if (isIncluded) {
              context.read<CookedMealsCubit>().removeMeal(widget.idMeal);
              message = 'Meal removed from the Cooked list.';
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
