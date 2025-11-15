import 'package:flutter/material.dart';
import 'package:recipe_book/Models/meal_row_data.dart';
import 'package:recipe_book/Widgets/meal_list.dart';
import 'package:recipe_book/Widgets/recipe_book_app_bar.dart';
import 'package:recipe_book/api_service.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  ApiService apiService = ApiService();

  @override
  State<StatefulWidget> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  String searchingStatus = '-1'; //initial state.

  bool isEmptySearch = false;

  List<MealRowData> resultMeals = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchMeal(String search) async {
    setState(() {
      searchingStatus = '1';
    });

    final searchResult = await widget.apiService.getMealsBySearch(search);
    resultMeals = MealRowData.fromJsonToMealList(searchResult);

    if (resultMeals.isEmpty) {
      setState(() {
        searchingStatus = '0';
        isEmptySearch = true;
      });
    } else {
      setState(() {
        searchingStatus = '0';
        isEmptySearch = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SearchBar(
                leading: Icon(Icons.search),
                controller: _searchController,
                onSubmitted: _searchMeal,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (searchingStatus == '0' && !isEmptySearch)
                      Expanded(child: MealList(meals: resultMeals)),
                    if (searchingStatus == '0' && isEmptySearch)
                      Text('No meal found'),
                    if (searchingStatus == '1') CircularProgressIndicator(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
