import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/Models/meal_row_data.dart';

class FavoriteMealsCubit extends Cubit<List<MealRowData>> {
  FavoriteMealsCubit() : super([]);

  void addMeal(meal) => emit([...state, meal]);

  void removeMeal(mealId) => emit(
    state.where((meal) {
      return mealId != meal.idMeal;
    }).toList(),
  );

  bool isIncluded(int mealId) {
    bool isIncluded = false;

    for(final meal in state){
      if(mealId == meal.idMeal){
        isIncluded = true;
        break;
      }
    }

    return isIncluded;
  }
  
  Icon getCheckmarkIcon(int mealId) {
    return  isIncluded(mealId)
            ? Icon(Icons.favorite, color: Colors.white)
            : Icon(Icons.favorite_border_outlined, color: Colors.white);
  }
}
