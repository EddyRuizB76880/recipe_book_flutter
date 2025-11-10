import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CookedMealsCubit extends Cubit<List<int>> {
  CookedMealsCubit() : super([]);

  void addMeal(mealId) => emit([...state, mealId]);

  void removeMeal(mealId) => emit(
    state.where((id) {
      return mealId != id;
    }).toList(),
  );

  bool isIncluded(int mealId) {
    return state.contains(mealId);
  }
  
  Icon getCheckmarkIcon(int mealId) {
    return  isIncluded(mealId)
            ? Icon(Icons.check_box_outlined, color: Colors.white)
            : Icon(Icons.check_box_outline_blank, color: Colors.white);
  }
}
