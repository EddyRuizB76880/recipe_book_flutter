import 'package:flutter/material.dart';
import 'package:recipe_book/Models/category.dart';
import 'package:recipe_book/Models/meal_row_data.dart';
import 'package:recipe_book/Widgets/app_bar.dart';

import 'package:recipe_book/Widgets/meal_row.dart';
import 'package:recipe_book/api_service.dart';

class MealListScreen extends StatefulWidget {
  const MealListScreen({super.key, required this.category});

  final Category category;

  @override
  State<MealListScreen> createState() {
    return _MealListScreenState();
  }
}

class _MealListScreenState extends State<MealListScreen> {
  late Future<List<MealRowData>> meals;

  ApiService apiService = ApiService();

  Future<List<MealRowData>> _loadCategoryMeals() async {
    final jsonData = await apiService.getMealsByCategory(
      widget.category.strCategory,
    );

    return MealRowData.fromJsonToMealList(jsonData);
  }

  @override
  void initState() {
    super.initState();
    meals = _loadCategoryMeals();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: meals,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (snapshot.data!.isEmpty) {
          return const Center(child: Text('No meals available.'));
        }
        //Todo
        return Scaffold(
          appBar: const RecipeBookAppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Text(
                    widget.category.strCategory,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(24),
                      children: [
                        for (final entry in snapshot.data!)
                          MealRow(
                            mealRowData: MealRowData(
                              idMeal: entry.idMeal,
                              strMeal: entry.strMeal,
                              strMealThumb: entry.strMealThumb,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
