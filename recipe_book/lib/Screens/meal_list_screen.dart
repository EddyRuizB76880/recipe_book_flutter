import 'package:flutter/material.dart';
import 'package:recipe_book/Models/category.dart';
import 'package:recipe_book/Models/meal_row_data.dart';
import 'package:recipe_book/Widgets/meal_list.dart';
import 'package:recipe_book/Widgets/recipe_book_app_bar.dart';
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
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (snapshot.data!.isEmpty) {
          return const Center(child: Text('No meals available.'));
        }
        //Todo
        return Scaffold(
          appBar: RecipeBookAppBar(title: widget.category.strCategory,),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Expanded(child: MealList(meals: snapshot.data!)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
